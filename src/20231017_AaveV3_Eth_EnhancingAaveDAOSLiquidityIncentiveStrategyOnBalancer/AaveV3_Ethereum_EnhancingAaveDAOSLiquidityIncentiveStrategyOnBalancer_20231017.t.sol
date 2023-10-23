// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017} from './AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.sol';

/**
 * @dev Test for AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017
 * command: make test-contract filter=AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017
 */
contract AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017_Test is
  ProtocolV2TestBase
{
  address public constant AURA_DAO_ECOSYSTEM_FUND = 0x3BC0Cb287f74504347D50fe3aDA6d90214E6F512;
  address public constant AURA_DAO_TREASURY = 0xfc78f8e1Af80A3bF5A1783BB59eD2d1b10f78cA9;
  address public constant GLC = 0x205e795336610f5131Be52F09218AF19f0f3eC60;
  address public constant VEBAL_TOKEN = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant AURA_TOKEN = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  uint256 public constant AURA_AMOUNT = 477_088e18;
  uint256 public constant USDC_AMOUNT_TO_AURA = 200_000e6;
  uint256 public constant USDC_AMOUNT_TO_GLC = 400_000e6;
  uint256 public constant AAVE_AMOUNT = 2_965e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18369074);
  }

  function testProposalExecution() public {
    AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017 proposal = new AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017();

    uint256 aUSDCV3BalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 aUSDCV2BalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 GLCAURABalanceBefore = IERC20(AURA_TOKEN).balanceOf(GLC);

    uint256 veBALBalanceBefore = IERC20(VEBAL_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR));
    uint256 GLCVEBALBalanceBefore = IERC20(VEBAL_TOKEN).balanceOf(GLC);

    hoax(AURA_DAO_TREASURY);
    IERC20(AURA_TOKEN).approve(AaveGovernanceV2.SHORT_EXECUTOR, AURA_AMOUNT);

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    uint256 aUSDCV3BalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 aUSDCV2BalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    uint256 GLCAURABalanceAfter = IERC20(AURA_TOKEN).balanceOf(GLC);
    uint256 GLCUSDCBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(GLC);
    uint256 GLCVEBALBalanceAfter = IERC20(VEBAL_TOKEN).balanceOf(GLC);
    uint256 veBALBalanceAfter = IERC20(VEBAL_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR));

    // Check if balances are updated as expected

    assertApproxEqAbs(
      aUSDCV3BalanceAfter,
      aUSDCV3BalanceBefore - USDC_AMOUNT_TO_AURA,
      1500 wei,
      'aUSDC_V3_LEFTOVER'
    );
    assertApproxEqAbs(
      aUSDCV2BalanceAfter,
      aUSDCV2BalanceBefore - USDC_AMOUNT_TO_GLC,
      1 ether,
      'aUSDC_V2_LEFTOVER'
    );

    assertApproxEqAbs(
      GLCAURABalanceAfter,
      GLCAURABalanceBefore + AURA_AMOUNT,
      1500 wei,
      'AURA_LEFTOVER'
    );

    assertApproxEqAbs(GLCUSDCBalance, USDC_AMOUNT_TO_GLC, 1500 wei, 'GLC_USDC_LEFTOVER');

    assertEq(veBALBalanceAfter, 0);
    assertEq(GLCVEBALBalanceAfter, GLCVEBALBalanceBefore + veBALBalanceBefore);
    assertGt(GLCVEBALBalanceAfter, GLCVEBALBalanceBefore);
  }
}
