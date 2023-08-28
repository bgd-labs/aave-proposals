// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity ^0.8.0;

import {AaveV3PayloadPolygon, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Increase stMATIC supply cap
 * @author defijesus.eth – TokenLogic
 * - Snapshot: Direct-to-AIP Framework
 * - Discussion: https://governance.aave.com/t/arfc-supply-cap-stmatic-polygon/14355
 */
contract AaveV3PolygonSupplyCapStmatic_20230810 is AaveV3PayloadPolygon {

    function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
        IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

        capsUpdate[0] = IEngine.CapsUpdate({
            asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
            supplyCap: 57_000_000,
            borrowCap: EngineFlags.KEEP_CURRENT
        });

        return capsUpdate;
    }
}