// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title SupplyCapLSTs
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-supply-cap-increase-lsts-on-polygon-v3/14696
 */
contract AaveV3_Polygon_SupplyCapLSTs_20230831 is AaveV3PayloadPolygon {

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      supplyCap: 66_000_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });
    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.wstETH_UNDERLYING,
      supplyCap: 4_125,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}