// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title Update Risk Parameters for WBTC, DAI, LINK and WMATIC Polygon
 * @author @ChaosLabsInc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x6dfc0cf7c95e91cfa9643a2621617c8210079aa2d44bdf8574ff1425a9ae52f0
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-polygon-2023-04-23/12828
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


    collateralUpdate[3] = IEngine.CollateralUpdate({
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
