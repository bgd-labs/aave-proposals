// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_ACIPhaseII_20231022} from './AaveV3_Ethereum_ACIPhaseII_20231022.sol';

/**
 * @dev Test for AaveV3_Ethereum_ACIPhaseII_20231022
 * command: make test-contract filter=AaveV3_Ethereum_ACIPhaseII_20231022
 */
contract AaveV3_Ethereum_ACIPhaseII_20231022_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_ACIPhaseII_20231022 internal proposal;

  address public constant ACI_TREASURY = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;

  ICollector public constant AAVE_COLLECTOR = ICollector(AaveV3Ethereum.COLLECTOR);

  address public constant GHO = AaveV3EthereumAssets.GHO_UNDERLYING;
  uint256 public constant STREAM_AMOUNT = 375_000 ether;
  uint256 public constant STREAM_DURATION = 180 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  address public constant GHO_WHALE = 0xE831C8903de820137c13681E78A5780afDdf7697;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18405191);
    proposal = new AaveV3_Ethereum_ACIPhaseII_20231022();
  }

  function testProposalExecution() public {
    uint256 nextCollectorStreamID = AAVE_COLLECTOR.getNextStreamId();

    uint256 ACIGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(ACI_TREASURY)
    );

    // the Collector gets a generous donation from a GHO whale

    hoax(GHO_WHALE);
    IERC20(GHO).transfer(address(AAVE_COLLECTOR), ACTUAL_STREAM_AMOUNT_GHO);

    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AAVE_COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AAVE_COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AAVE_COLLECTOR));
      assertEq(recipientGHO, ACI_TREASURY);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, address(GHO));
      assertEq(stopTimeGHO - startTimeGHO, STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // checking if the ACI can withdraw from the stream

    vm.startPrank(ACI_TREASURY);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 nextACIGHOBalance = IERC20(GHO).balanceOf(ACI_TREASURY);

    assertEq(ACIGHOBalanceBefore, nextACIGHOBalance - ACTUAL_STREAM_AMOUNT_GHO);

    // Check Collector balance after stream withdrawal

    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AAVE_COLLECTOR)
    );

    assertEq(CollectorV3GHOBalanceAfter, CollectorV3GHOBalanceBefore - ACTUAL_STREAM_AMOUNT_GHO);

    vm.stopPrank();
  }
}
