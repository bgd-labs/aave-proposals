// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816} from './AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816.sol';

/**
 * @dev Test for AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816
 * command: make test-contract filter=AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816
 */
contract AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816_Test is
  ProtocolV3TestBase
{
  AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816 internal proposal;

  IERC20 public constant AUSDT = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN);

  ICollector public constant AAVE_COLLECTOR = AaveV3Ethereum.COLLECTOR;
  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  uint256 public constant STREAM_AMOUNT = 400_000e6;
  uint256 public constant STREAM_DURATION = 77 days;

  uint256 public constant actualAmountaUSDT = (STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17926515);
    proposal = new AaveV3_Ethereum_ChaosLabsScopeAndCompensationAmendment_20230816();
  }

  function testProposalExecution() public {
    // Capturing next Stream IDs before proposal is executed
    uint256 nextCollectorStreamID = AAVE_COLLECTOR.getNextStreamId();
    uint256 collectorV2aUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorV3aUSDTBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    // Check Funds transfer from V2 to V3 Collector
    uint256 collectorV2aUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorV3aUSDTBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorV2aUSDTBalanceAfter,
      collectorV2aUSDTBalanceBefore - actualAmountaUSDT,
      50e6
    );
    assertApproxEqAbs(
      collectorV3aUSDTBalanceAfter,
      collectorV3aUSDTBalanceBefore + actualAmountaUSDT,
      50e6
    );

    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderUSDT,
        address recipientUSDT,
        uint256 depositUSDT,
        address tokenAddressUSDT,
        uint256 startTimeUSDT,
        uint256 stopTimeUSDT,
        uint256 remainingBalanceUSDT,

      ) = AAVE_COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderUSDT, address(AAVE_COLLECTOR));
      assertEq(recipientUSDT, CHAOS_LABS_TREASURY);
      assertEq(depositUSDT, actualAmountaUSDT);
      assertEq(tokenAddressUSDT, address(AUSDT));
      assertEq(stopTimeUSDT - startTimeUSDT, STREAM_DURATION);
      assertEq(remainingBalanceUSDT, actualAmountaUSDT);
    }

    // Checking if Chaos can withdraw from streams
    uint256 initialChaosUSDTBalance = AUSDT.balanceOf(CHAOS_LABS_TREASURY);
    vm.startPrank(CHAOS_LABS_TREASURY);
    vm.warp(block.timestamp + (STREAM_DURATION / 2));
    uint256 firstPayment = actualAmountaUSDT / 2;

    AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, firstPayment);

    uint256 halfChaosUSDTBalance = AUSDT.balanceOf(CHAOS_LABS_TREASURY);
    assertEq(initialChaosUSDTBalance, halfChaosUSDTBalance - (actualAmountaUSDT / 2));

    vm.warp(block.timestamp + (STREAM_DURATION / 2) + 1 days);
    uint256 midStreamChaosUSDTBalance = AUSDT.balanceOf(CHAOS_LABS_TREASURY);
    uint256 secondPayment = actualAmountaUSDT - firstPayment;

    AAVE_COLLECTOR.withdrawFromStream(nextCollectorStreamID, actualAmountaUSDT / 2);
    uint256 endChaosUSDTBalance = AUSDT.balanceOf(CHAOS_LABS_TREASURY);

    assertEq(midStreamChaosUSDTBalance, endChaosUSDTBalance - secondPayment);

    vm.stopPrank();
  }
}
