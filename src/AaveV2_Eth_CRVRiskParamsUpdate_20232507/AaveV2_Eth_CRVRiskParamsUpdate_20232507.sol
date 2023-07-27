// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PayloadEthereum, IEngine, EngineFlags} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs Risk Parameter Updates - CRV Aave V2 Ethereum
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0x8b992ee05d9e87ef0dab2cb7178c24f7b4b6f5d79561ad33298550b3c8d9fe89
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-crv-aave-v2-ethereum-2023-07-10/13952
 */
contract AaveV2_Eth_CRVRiskParamsUpdate_20232507 is AaveV2PayloadEthereum {
  uint256 public constant CRV_LTV = 43_00; /// 49 -> 43
  uint256 public constant CRV_LIQUIDATION_THRESHOLD = 49_00; // 55 -> 49
  uint256 public constant CRV_LIQUIDATION_BONUS = 10800; //unchanged

  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      CRV_LTV,
      CRV_LIQUIDATION_THRESHOLD,
      CRV_LIQUIDATION_BONUS
    );
  }
}
