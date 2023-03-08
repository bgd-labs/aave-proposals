// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload change risk params for multi assets AAVE V3 Optimism
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xdbc2ba0eb1308372d56c637aca77c143722f3efbc8191f63a99fcb26c94b5e7f
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-02-28/12099
 */
contract AaveV3OptRiskParmasPayload is IProposalGenericExecutor {

  uint256 public constant WETH_LIQ_THRESHOLD = 8500; // 85%
  uint256 public constant WETH_LTV = 8250; // 82.5%
  uint256 public constant WETH_LIQ_BONUS = 10500; // 5% no change

  uint256 public constant WBTC_LIQ_THRESHOLD = 7800; // 78%
  uint256 public constant WBTC_LTV = 7300; // 73%
  uint256 public constant WBTC_LIQ_BONUS = 10700; // 7%

  uint256 public constant DAI_LIQ_THRESHOLD = 8200; // 82%
  uint256 public constant DAI_LTV = 7700; // 77%
  uint256 public constant DAI_LIQ_BONUS = 10500; // 5% no change

  uint256 public constant USDC_LIQ_THRESHOLD = 8600; // 865
  uint256 public constant USDC_LTV = 8100; // 81%
  uint256 public constant USDC_LIQ_BONUS = 10500; // 5% no change


  function execute() external {

    // WETH
    AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3OptimismAssets.WETH_UNDERLYING,
      WETH_LTV,
      WETH_LIQ_THRESHOLD,
      WETH_LIQ_BONUS
    );

    // WBTC
    AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3OptimismAssets.WBTC_UNDERLYING,
      WBTC_LTV,
      WBTC_LIQ_THRESHOLD,
      WBTC_LIQ_BONUS
    );

    // DAI
    AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3OptimismAssets.DAI_UNDERLYING,
      DAI_LTV,
      DAI_LIQ_THRESHOLD,
      DAI_LIQ_BONUS
    );

    // USDC
    AaveV3Optimism.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3OptimismAssets.USDC_UNDERLYING,
      USDC_LTV,
      USDC_LIQ_THRESHOLD,
      USDC_LIQ_BONUS
    );
  }
}
