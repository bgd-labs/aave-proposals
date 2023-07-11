// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';


/**
 * @title Make USDT a collateral for Aave V3 ETH Pool
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Eth_AaveV3USDTRiskParams_20231107 is AaveV3PayloadEthereum {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      ltv: 74_00,
      liqThreshold: 76_00,
      liqBonus: 4_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });
    return collateralUpdate;
  }
}