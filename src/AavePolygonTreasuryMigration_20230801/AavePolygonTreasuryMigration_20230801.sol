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
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IMigrationHelper} from './IMigrationHelper.sol';

/**
 * @dev Redeem aTokens from Aave v2 Polygon and deposit the underlying assets into Aave v3 Polygon. 
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882
 * - Discussion: https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248
 */
contract AavePolygonTreasuryMigration_20230801 is AaveV2PayloadPolygon {

  function _postExecute() internal override {
    IMigrationHelper helper = IMigrationHelper(AaveV2Polygon.MIGRATION_HELPER);
    address COLLECTOR = address(AaveV2Polygon.COLLECTOR);

    address[] memory ASSETS_TO_MIGRATE = new address[](10);
    ASSETS_TO_MIGRATE[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    ASSETS_TO_MIGRATE[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    ASSETS_TO_MIGRATE[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    ASSETS_TO_MIGRATE[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    ASSETS_TO_MIGRATE[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    ASSETS_TO_MIGRATE[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    ASSETS_TO_MIGRATE[6] = AaveV2PolygonAssets.BAL_UNDERLYING;
    ASSETS_TO_MIGRATE[7] = AaveV2PolygonAssets.CRV_UNDERLYING;
    ASSETS_TO_MIGRATE[8] = AaveV2PolygonAssets.GHST_UNDERLYING;
    ASSETS_TO_MIGRATE[9] = AaveV2PolygonAssets.LINK_UNDERLYING;

    IMigrationHelper.RepaySimpleInput[] memory POSITIONS_TO_REPAY = new IMigrationHelper.RepaySimpleInput[](0);
    IMigrationHelper.PermitInput[] memory PERMITS = new IMigrationHelper.PermitInput[](0);
    IMigrationHelper.CreditDelegationInput[] memory CREDIT_DELEGATION_PERMITS = new IMigrationHelper.CreditDelegationInput[](0);

    uint256 i = 0;

    for(;i < ASSETS_TO_MIGRATE.length;) {
        address aToken = helper.aTokens(ASSETS_TO_MIGRATE[i]);
        uint256 amount = IERC20(aToken).balanceOf(COLLECTOR);
        AaveV2Polygon.COLLECTOR.transfer(aToken, address(this), amount);
        IERC20(aToken).approve(AaveV2Polygon.MIGRATION_HELPER, amount);
        unchecked {
            i++;
        }
    }

    helper.migrate(ASSETS_TO_MIGRATE, POSITIONS_TO_REPAY, PERMITS, CREDIT_DELEGATION_PERMITS);

    for(i = 0; i < ASSETS_TO_MIGRATE.length;) {
        address aToken = helper.aTokens(ASSETS_TO_MIGRATE[i]);
        IERC20(aToken).transfer(
            COLLECTOR,
            IERC20(aToken).balanceOf(address(this))
        );
        unchecked {
            i++;
        }
    }
  }
}