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
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IMigrationHelper} from 'aave-address-book/common/IMigrationHelper.sol';

/**
 * @dev Redeem aTokens from Aave v2 Avalanche and deposit the underlying assets into Aave v3 Avalanche. 
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882
 * - Discussion: https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248
 */
contract AaveAvalancheTreasuryMigration_20230903 is IProposalGenericExecutor {

  function execute() external {
    IMigrationHelper MIGRATION_HELPER = IMigrationHelper(AaveV2Avalanche.MIGRATION_HELPER);

    address[] memory ASSETS_TO_MIGRATE = new address[](4);
    ASSETS_TO_MIGRATE[0] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    ASSETS_TO_MIGRATE[1] = AaveV2AvalancheAssets.WBTCe_UNDERLYING;
    ASSETS_TO_MIGRATE[2] = AaveV2AvalancheAssets.WETHe_UNDERLYING;
    ASSETS_TO_MIGRATE[3] = AaveV2AvalancheAssets.WAVAX_UNDERLYING;

    IMigrationHelper.RepaySimpleInput[] memory POSITIONS_TO_REPAY = new IMigrationHelper.RepaySimpleInput[](0);
    IMigrationHelper.PermitInput[] memory PERMITS = new IMigrationHelper.PermitInput[](0);
    IMigrationHelper.CreditDelegationInput[] memory CREDIT_DELEGATION_PERMITS = new IMigrationHelper.CreditDelegationInput[](0);

    uint256 i = 0;

    for(;i < ASSETS_TO_MIGRATE.length;) {
        address aToken = MIGRATION_HELPER.aTokens(ASSETS_TO_MIGRATE[i]);
        uint256 amount = IERC20(aToken).balanceOf(address(AaveV2Avalanche.COLLECTOR));
        AaveV2Avalanche.COLLECTOR.transfer(aToken, address(this), amount);
        SafeERC20.forceApprove(IERC20(aToken), AaveV2Avalanche.MIGRATION_HELPER, amount);
        unchecked {
            i++;
        }
    }

    MIGRATION_HELPER.migrate(ASSETS_TO_MIGRATE, POSITIONS_TO_REPAY, PERMITS, CREDIT_DELEGATION_PERMITS);

    address[] memory NEW_ASSETS_MIGRATED = new address[](4);
    NEW_ASSETS_MIGRATED[0] = AaveV3AvalancheAssets.DAIe_A_TOKEN;
    NEW_ASSETS_MIGRATED[1] = AaveV3AvalancheAssets.WBTCe_A_TOKEN;
    NEW_ASSETS_MIGRATED[2] = AaveV3AvalancheAssets.WETHe_A_TOKEN;
    NEW_ASSETS_MIGRATED[3] = AaveV3AvalancheAssets.WAVAX_A_TOKEN;

    for(i = 0; i < NEW_ASSETS_MIGRATED.length;) {
        SafeERC20.safeTransfer(
            IERC20(NEW_ASSETS_MIGRATED[i]), 
            address(AaveV3Avalanche.COLLECTOR), 
            IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(this))
        );
        unchecked {
            i++;
        }
    }
  }
}