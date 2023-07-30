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
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @dev Update Reserve Factors (RF) on Polygon v2 to encourage users to migrate funds to v3.
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbe8f3f1df222a53d8ca05f8be0ec56aa9f169e9881f98e6534e078d155854713
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937
 */
contract AaveV2PolygonReserveFactorUpdate_20230717 is AaveV2PayloadPolygon {

  function _postExecute() internal override {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, 26_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, 28_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, 27_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WBTC_UNDERLYING, 60_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WETH_UNDERLYING, 50_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.WMATIC_UNDERLYING, 46_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.BAL_UNDERLYING, 37_00);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.CRV_UNDERLYING, 99_99);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.GHST_UNDERLYING, 99_99);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.LINK_UNDERLYING, 99_99);
  }
}