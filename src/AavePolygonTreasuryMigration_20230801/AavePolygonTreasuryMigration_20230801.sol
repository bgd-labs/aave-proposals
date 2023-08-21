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

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IMigrationHelper} from 'aave-address-book/common/IMigrationHelper.sol';

/**
 * @dev Redeem aTokens from Aave v2 Polygon and deposit the underlying assets into Aave v3 Polygon. 
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882
 * - Discussion: https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248
 */
contract AavePolygonTreasuryMigration_20230801 is IProposalGenericExecutor {

  function execute() external {
    IMigrationHelper MIGRATION_HELPER = IMigrationHelper(AaveV2Polygon.MIGRATION_HELPER);

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
        address aToken = MIGRATION_HELPER.aTokens(ASSETS_TO_MIGRATE[i]);
        uint256 amount = IERC20(aToken).balanceOf(address(AaveV2Polygon.COLLECTOR));
        AaveV2Polygon.COLLECTOR.transfer(aToken, address(this), amount);
        SafeERC20.forceApprove(IERC20(aToken), AaveV2Polygon.MIGRATION_HELPER, amount);
        unchecked {
            i++;
        }
    }

    MIGRATION_HELPER.migrate(ASSETS_TO_MIGRATE, POSITIONS_TO_REPAY, PERMITS, CREDIT_DELEGATION_PERMITS);

    address[] memory NEW_ASSETS_MIGRATED = new address[](10);
    NEW_ASSETS_MIGRATED[0] = AaveV3PolygonAssets.DAI_A_TOKEN;
    NEW_ASSETS_MIGRATED[1] = AaveV3PolygonAssets.USDC_A_TOKEN;
    NEW_ASSETS_MIGRATED[2] = AaveV3PolygonAssets.USDT_A_TOKEN;
    NEW_ASSETS_MIGRATED[3] = AaveV3PolygonAssets.WBTC_A_TOKEN;
    NEW_ASSETS_MIGRATED[4] = AaveV3PolygonAssets.WETH_A_TOKEN;
    NEW_ASSETS_MIGRATED[5] = AaveV3PolygonAssets.WMATIC_A_TOKEN;
    NEW_ASSETS_MIGRATED[6] = AaveV3PolygonAssets.BAL_A_TOKEN;
    NEW_ASSETS_MIGRATED[7] = AaveV3PolygonAssets.CRV_A_TOKEN;
    NEW_ASSETS_MIGRATED[8] = AaveV3PolygonAssets.GHST_A_TOKEN;
    NEW_ASSETS_MIGRATED[9] = AaveV3PolygonAssets.LINK_A_TOKEN;

    for(i = 0; i < NEW_ASSETS_MIGRATED.length;) {
        SafeERC20.safeTransfer(
            IERC20(NEW_ASSETS_MIGRATED[i]), 
            address(AaveV3Polygon.COLLECTOR), 
            IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(this))
        );
        unchecked {
            i++;
        }
    }
  }
}