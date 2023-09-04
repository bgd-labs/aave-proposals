// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadPolygon, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title CapsUpgrade_20230904
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: no snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-caps-increase-2023-08-31/14698
 */
contract AaveV3_Polygon_CapsUpgrade_20230904_20230904 is AaveV3PayloadPolygon {
  function _preExecute() internal override {}

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.DPI_UNDERLYING,
      supplyCap: 2_460,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
