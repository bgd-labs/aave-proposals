// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title Update eurs borrow cap on Aave V3 Polygon
 * @author Gauntlet
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/gauntlet-recommendations-for-eurs-on-v3-polygon/12798
 */
contract AaveV3PolRiskParams_20230423 is AaveV3PayloadPolygon {
  function collateralsUpdates() public pure override returns (IEngine.CollateralUpdate[] memory) {
    IEngine.CollateralUpdate[] memory collateralUpdate = new IEngine.CollateralUpdate[](4);

    collateralUpdate[0] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.WBTC_UNDERLYING,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus:EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    collateralUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.DAI_UNDERLYING,
      ltv: 76_00,
      liqThreshold: 81_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });


    collateralUpdate[2] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.LINK_UNDERLYING,
      ltv: 53_00,
      liqThreshold: 68_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });


    collateralUpdate[1] = IEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.WMATIC_UNDERLYING,
      ltv: 68_00,
      liqThreshold: 73_00,
      liqBonus: 7_00,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT,
      eModeCategory: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
  }
}
