// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {BridgeExecutorHelpers} from 'aave-helpers/BridgeExecutorHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IStateReceiver} from 'governance-crosschain-bridges/contracts/dependencies/polygon/fxportal/FxChild.sol';
import {AaveV3PolFreezeAGEUR} from '../../contracts/polygon/AaveV3PolFreezeAGEUR.sol';
import {DeployL1PolygonProposal} from '../../../script/DeployL1PolygonProposal.s.sol';

contract AaveV3PolJEURAGEURFreeze is ProtocolV3TestBase {
  uint256 mainnetFork;
  uint256 polygonFork;

  AaveV3PolFreezeAGEUR public agEURPayload;

  address public constant BRIDGE_ADMIN =
    0x0000000000000000000000000000000000001001;
  address public constant FX_CHILD_ADDRESS =
    0x8397259c983751DAf40400790063935a11afa28a;

  function setUp() public {
    polygonFork = vm.createFork(vm.rpcUrl('polygon'), 38224950);
    mainnetFork = vm.createFork(vm.rpcUrl('mainnet'), 16432600);
  }

  // utility to transform memory to calldata so array range access is available
  function _cutBytes(bytes calldata input)
    public
    pure
    returns (bytes calldata)
  {
    return input[64:];
  }

  function testProposalE2E() public {
    vm.selectFork(polygonFork);

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory configAGEURBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      'agEUR'
    );

    // 1. deploy l2 payload
    agEURPayload = new AaveV3PolFreezeAGEUR();

    // 2. create l1 proposal
    vm.selectFork(mainnetFork);
    vm.startPrank(GovHelpers.AAVE_WHALE);
    uint256 proposalId = DeployL1PolygonProposal._deployL1Proposal(
      address(agEURPayload),
      bytes32('')
    );
    vm.stopPrank();

    // 3. execute proposal and record logs so we can extract the emitted StateSynced event
    vm.recordLogs();
    GovHelpers.passVoteAndExecute(vm, proposalId);

    Vm.Log[] memory entries = vm.getRecordedLogs();
    assertEq(
      keccak256('StateSynced(uint256,address,bytes)'),
      entries[2].topics[0]
    );
    assertEq(address(uint160(uint256(entries[2].topics[2]))), FX_CHILD_ADDRESS);

    // 4. mock the receive on l2 with the data emitted on StateSynced
    vm.selectFork(polygonFork);
    vm.startPrank(BRIDGE_ADMIN);
    IStateReceiver(FX_CHILD_ADDRESS).onStateReceive(
      uint256(entries[2].topics[1]),
      this._cutBytes(entries[2].data)
    );
    vm.stopPrank();

    // 5. Forward time & execute proposal
    BridgeExecutorHelpers.waitAndExecuteLatest(
      vm,
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    // 6. verify results
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(
      AaveV3Polygon.POOL
    );

    // TODO add try catch for frozen
    _validateReserveConfig(configAGEURBefore, allConfigsAfter);
  }
}
