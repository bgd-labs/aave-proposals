// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';


/**
 * @title Increase MaticX supply cap
 * @author Alice Rozengarden (@Rozengarden - Aave-chan initiative)
 * - Snapshot: Direct-to-AIP Framework
 * - Discussion: https://governance.aave.com/t/arfc-increase-maticx-supply-cap/14341
 */
contract AaveV3_Pol_CapsUpdate_20230608 is AaveV3PayloadPolygon {
    uint256 public constant NEW_SUPPLY_CAP = 62_000_000;

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
