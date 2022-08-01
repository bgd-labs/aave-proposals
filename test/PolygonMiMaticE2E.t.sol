// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import 'forge-std/console.sol';
import {Test} from 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {GenericPolygonExecutor} from '../src/contracts/polygon/GenericPolygonExecutor.sol';
import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';
import {IStateReceiver} from '../src/interfaces/IFx.sol';
import {IBridgeExecutor} from '../src/interfaces/IBridgeExecutor.sol';
import {DeployL1Proposal} from '../script/DeployL1Proposal.s.sol';

contract PolygonMiMaticE2ETest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 polygonFork;

  MiMaticPayload public miMaticPayload;
  DeployL1Proposal deployl1Proposal;
  address public constant BRIDGE_ADMIN =
    0x0000000000000000000000000000000000001001;
  address public constant FX_CHILD_ADDRESS =
    0x8397259c983751DAf40400790063935a11afa28a;

  function setUp() public {
    polygonFork = vm.createSelectFork('https://polygon-rpc.com', 31237525);
    mainnetFork = vm.createSelectFork('https://rpc.flashbots.net/', 15231241);
    deployl1Proposal = new DeployL1Proposal();
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input) public returns (bytes calldata) {
    return input[64:];
  }

  function testL2ExecuteBridger() public {
    // 0. deploy generic executor
    vm.selectFork(mainnetFork);
    GenericPolygonExecutor bridgeExecutor = new GenericPolygonExecutor(); // TODO: should be replaced with address once deployed

    // 1. deploy l2 payload
    vm.selectFork(polygonFork);
    miMaticPayload = new MiMaticPayload();

    vm.selectFork(mainnetFork);
    uint256 proposalId = deployl1Proposal.createProposal(
      address(bridgeExecutor),
      address(miMaticPayload)
    );

    // 2. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('StateSynced(uint256,address,bytes)'),
      entries[2].topics[0]
    );
    assertEq(address(uint160(uint256(entries[2].topics[2]))), FX_CHILD_ADDRESS);

    vm.selectFork(polygonFork);
    vm.stopPrank();
    vm.startPrank(BRIDGE_ADMIN);

    // 3. mock the receive on l2 with the data emitted on StateSynced
    IStateReceiver(FX_CHILD_ADDRESS).onStateReceive(
      uint256(entries[2].topics[1]),
      this._cutBytes(entries[2].data)
    );

    // 4. execute proposal on l2
    vm.warp(
      block.timestamp + IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).getDelay() + 1
    );
    // execute the proposal
    IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).execute(
      IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).getActionsSetCount() - 1
    );
  }
}
