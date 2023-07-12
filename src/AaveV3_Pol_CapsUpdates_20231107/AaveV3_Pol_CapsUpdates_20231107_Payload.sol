// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title MaticX Polygon Supply Cap Update
 * @author Llama
 * - Discussion: https://governance.aave.com/t/arfc-polygon-supply-cap-update-07-07-2023/13928
 */
contract AaveV3_Pol_CapsUpdates_20231107_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP_MATICX = 50_600_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP_MATICX,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
