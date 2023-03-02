// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This steward update risk params for multiple assets on AAVE V3 Arbitrum
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-risk-parameter-updates-aave-v3-arbitrum-2023-02-20/11986
 */
contract AaveV3ArbRiskParamsPayload is IProposalGenericExecutor {
  address public constant WETH = AaveV3ArbitrumAssets.WETH_UNDERLYING;
  address public constant WBTC = AaveV3ArbitrumAssets.WBTC_UNDERLYING;
  address public constant DAI = AaveV3ArbitrumAssets.DAI_UNDERLYING;
  address public constant USDC = AaveV3ArbitrumAssets.USDC_UNDERLYING;

  uint256 public constant WETH_LT = 8500; // 85%
  uint256 public constant WETH_LTV = 8250; // 82.5%
  uint256 public constant WETH_LIQ_BONUS = 10500; // 5%

  uint256 public constant WBTC_LT = 7800; // 78%
  uint256 public constant WBTC_LTV = 7300; // 73%
  uint256 public constant WBTC_LIQ_BONUS = 10700; //10% -> 7% 

  uint256 public constant DAI_LT = 8200; // 82%
  uint256 public constant DAI_LTV = 7700; // 77%
  uint256 public constant DAI_LIQ_BONUS = 10500; // 5%

  uint256 public constant USDC_LT = 8600; // 86%
  uint256 public constant USDC_LTV = 8100; // 81%
  uint256 public constant USDC_LIQ_BONUS = 10500; // 5%

  function execute() external {

    // WETH
    AaveV3Arbitrum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: WETH,
      ltv: WETH_LTV,
      liquidationThreshold: WETH_LT,
      liquidationBonus: WETH_LIQ_BONUS});

    // WBTC
    AaveV3Arbitrum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: WBTC,
      ltv: WBTC_LTV,
      liquidationThreshold: WBTC_LT,
      liquidationBonus: WBTC_LIQ_BONUS});

    // DAI
    AaveV3Arbitrum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: DAI,
      ltv: DAI_LTV,
      liquidationThreshold: DAI_LT,
      liquidationBonus: DAI_LIQ_BONUS});

    // USDC
    AaveV3Arbitrum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: USDC,
      ltv: USDC_LTV,
      liquidationThreshold: USDC_LT,
      liquidationBonus: USDC_LIQ_BONUS});

  }
}