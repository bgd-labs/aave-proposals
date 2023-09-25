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

import 'aave-helpers/v2-config-engine/AaveV2PayloadPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @dev Update Reserve Factors (RF) on Polygon v2 to encourage users to migrate funds to v3.
 * @author defijesus.eth - TokenLogic
 * - Snapshot: Direct-to-AIP Framework
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/6
 */
contract AaveV2PolygonReserveFactorUpdate_20230828 is AaveV2PayloadPolygon {

  function _postExecute() internal override {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, 31_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, 33_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, 32_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WBTC_UNDERLYING, 65_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WETH_UNDERLYING, 55_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WMATIC_UNDERLYING, 51_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.BAL_UNDERLYING, 42_00);
  }
}