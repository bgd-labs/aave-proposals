// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import 'forge-std/console.sol';
import {Test} from 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {GenericL2Executor} from '../src/contracts/GenericL2Executor.sol';
import {L2Payload} from '../src/contracts/L2Payload.sol';
import {IStateReceiver} from '../src/interfaces/IFx.sol';
import {IBridgeExecutor} from '../src/interfaces/IBridgeExecutor.sol';
import {Deploy} from '../script/Deploy.s.sol';

contract L2PayloadTest is Test {
  // the identifiers of the forks
  uint256 mainnetFork;
  uint256 l2Fork;
  L2Payload public l2payload;
  Deploy deploy;
  address public constant BRIDGE_ADMIN =
    0x0000000000000000000000000000000000001001;
  address public constant FX_ROOT_ADDRESS =
    0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2;

  function setUp() public {
    l2Fork = vm.createSelectFork('https://polygon-rpc.com', 31237525);
    mainnetFork = vm.createSelectFork('https://rpc.flashbots.net/', 15231241);
    deploy = new Deploy();
  }

  struct EventData {
    bytes32 what;
    uint256 topic1;
    address receiver;
    bytes rest;
  }

  function _cutBytes(bytes calldata input) public returns (bytes calldata) {
    return input[64:];
  }

  function testL2ExecuteBridger() public {
    // deploy l2 payload
    vm.selectFork(l2Fork);
    l2payload = new L2Payload();

    // deploy generic executor
    vm.selectFork(mainnetFork);
    GenericL2Executor bridger = new GenericL2Executor(
      FX_ROOT_ADDRESS,
      AaveV3Polygon.ACL_ADMIN
    );

    uint256 proposalId = deploy.createProposal(
      address(bridger),
      address(l2payload)
    );

    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('StateSynced(uint256,address,bytes)'),
      entries[2].topics[0]
    );
    address fxChild = address(uint160(uint256(entries[2].topics[2])));
    console.log(uint256(entries[2].topics[1]));
    console.log(address(uint160(uint256(entries[2].topics[2]))));
    assertEq(
      address(uint160(uint256(entries[2].topics[2]))),
      deploy.FX_CHILD_ADDRESS()
    );

    vm.selectFork(l2Fork);
    vm.stopPrank();
    vm.startPrank(BRIDGE_ADMIN);

    // bridge payload which will queue the proposal
    IStateReceiver(fxChild).onStateReceive(
      uint256(entries[2].topics[1]),
      this._cutBytes(entries[2].data)
    );

    vm.warp(
      block.timestamp + IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).getDelay() + 1
    );
    // execute the proposal
    IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).execute(
      IBridgeExecutor(AaveV3Polygon.ACL_ADMIN).getActionsSetCount() - 1
    );
  }
}
