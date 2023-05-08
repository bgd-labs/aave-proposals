// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title AaveV3PolCapsUpdates_20230503_Payload
 * @author Llama
 * @dev Update the Aave V3 Polygon MaticX supply cap
 * Forum: https://governance.aave.com/t/arfc-maticx-supply-cap-increase-polygon-v3/12657
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7057a6311c791ebd57b93acb4a231dfd4fb92755fc02fa1de4723d0a5510d2ed
 */
contract AaveV3PolCapsUpdates_20230503_Payload is AaveV3PayloadPolygon {
  uint256 public constant NEW_SUPPLY_CAP = 29_300_000;

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      supplyCap: NEW_SUPPLY_CAP,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
