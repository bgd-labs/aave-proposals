
// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230610_Payload
 * @author Llama
 * @dev Increase SupplyCap stMATIC and MaticX on Polygon v3
 * Forum: https://governance.aave.com/t/arfc-polygon-v3-supply-cap-update-2023-05-21/13161
 */
contract AaveV3PolCapsUpdates_20230610_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP_STMATIC = 40_000_000;
  uint256 public constant NEW_SUPPLY_CAP_MATICX = 38_000_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](2);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_STMATIC,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_MATICX,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
