// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230418_Payload
 * @author Llama
 * @dev Update the Aave V3 Polygon stMATIC supply cap
 * Governance Forum Post: https://governance.aave.com/t/arfc-stmatic-supply-cap-increase-polygon-v3/12606
 */
contract AaveV3PolCapsUpdates_20230418_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP = 25_000_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
