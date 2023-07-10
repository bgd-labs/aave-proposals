// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Update Risk Parameters for CRV on Aave V3 Polygon
 * @author @ChaosLabsInc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0b04533e8d9ab0f259bd19874ef5b66008a53f55313116cc054e0aa705fa01b6
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-update-crv-aave-v3-polygon-2023-06-20/13767
 */
contract AaveV3PolCRVRiskParams_20230702 is AaveV3PayloadPolygon {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.CRV_UNDERLYING,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
