// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title This proposal updates FEI risk params on Aave V2 Ethereum
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe6fbf8d933858a15ddb4ae6101ccaec3e16d01c8e9172fc2aa8a51972ec67837
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-fei-on-aave-v2-ethereum-2023-6-22/13782
 */
contract AaveV2EthFEIRiskParams_20230703 {
  uint256 public constant FEI_LTV = 0; /// 65 -> 0
  uint256 public constant FEI_LIQUIDATION_THRESHOLD = 1_00; // 75 -> 1
  uint256 public constant FEI_LIQUIDATION_BONUS = 10650; //unchanged

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.FEI_UNDERLYING,
      FEI_LTV,
      FEI_LIQUIDATION_THRESHOLD,
      FEI_LIQUIDATION_BONUS
    );
  }
}
