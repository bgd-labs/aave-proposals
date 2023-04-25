// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title Update eurs borrow cap on Aave V3 Polygon
 * @author Gauntlet
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/gauntlet-recommendations-for-eurs-on-v3-polygon/12798
 */
contract AaveV3PolCapsUpdate_20230421 is AaveV3PayloadPolygon {
  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.EURS_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 1_500_000
    });

    return capsUpdate;
  }
}
