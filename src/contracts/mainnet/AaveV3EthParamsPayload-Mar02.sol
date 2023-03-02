// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal change USDC and DAI risk parameters
 * @author chaos labs
 * - Discussion: https://governance.aave.com/t/arc-chaos-labs-risk-parameter-updates-aave-v3-ethereum-2023-02-22/12015
 */

contract AaveV3EthParamsPayload is IProposalGenericExecutor {
  address public constant USDC = AaveV3EthereumAssets.USDC_UNDERLYING;
  address public constant DAI = AaveV3EthereumAssets.DAI_UNDERLYING;


  uint256 public constant USDC_LT = 7900; // 79%
  uint256 public constant USDC_LTV = 7700; // 77%
  uint256 public constant USDC_LIQ_BONUS = 10450; // 4.5%

  uint256 public constant DAI_LT = 8000; // 80%
  uint256 public constant DAI_LTV = 6700; // 67%
  uint256 public constant DAI_LIQ_BONUS = 10400; // 4%

  function execute() external {

    // USDC
    AaveV3Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: USDC,
      ltv: USDC_LTV,
      liquidationThreshold: USDC_LT,
      liquidationBonus: USDC_LIQ_BONUS});

    // DAI
    AaveV3Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: DAI,
      ltv: DAI_LTV,
      liquidationThreshold: DAI_LT,
      liquidationBonus: DAI_LIQ_BONUS});
  }
}