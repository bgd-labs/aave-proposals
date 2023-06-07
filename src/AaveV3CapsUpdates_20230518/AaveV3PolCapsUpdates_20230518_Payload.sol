// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230518_Payload
 * @author Llama
 * @dev Update the Aave V3 Polygon wMATIC Supply and Borrow caps
 * Forum: https://governance.aave.com/t/arfc-wmatic-supply-borrow-cap-increase-polygon-v3/13095
 */
contract AaveV3PolCapsUpdates_20230518_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP = 90_000_000;
  uint256 public constant NEW_BORROW_CAP = 50_000_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.WMATIC_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: NEW_BORROW_CAP
    });

    return capsUpdate;
  }
}
