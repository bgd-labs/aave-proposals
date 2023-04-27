// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PayloadPolygon, IEngine, Rates, EngineFlags, AaveV3PolygonAssets } from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title update LINK and WBTC supply caps on Aave V3 Polygon
 * @author @ChaosLabsInc 
 * - Snapshot: Direct-to-AIP framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-04-21-2023/12845/1
 */
contract AaveV3POLSupplyBorrowUpdate_20230427 is AaveV3PayloadPolygon {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.WBTC_UNDERLYING,
      supplyCap: 3_100,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.LINK_UNDERLYING,
      supplyCap: 370_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
