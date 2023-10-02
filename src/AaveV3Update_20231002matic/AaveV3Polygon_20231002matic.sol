// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine,EngineFlags,Rates} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {
  AaveV3PayloadPolygon,
  AaveV3PolygonAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
  * @title Gauntlet Recommendations to Lower stMATIC/MaticX non-emode LT/LTV on Polygon v3
  * @author Gauntlet
  * - Discussion: https://governance.aave.com/t/arfc-gauntlet-recommendation-to-lower-stmatic-maticx-non-emode-lt/14859
 */
contract AaveV3PolygonUpdate20231002maticPayload is AaveV3PayloadPolygon {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdates = new IEngine.CollateralUpdate[](2);

    collateralUpdates[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      ltv: 4500,
      liqThreshold: 6200,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    collateralUpdates[1] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      ltv: 4500,
      liqThreshold: 6000,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdates;
  }
}