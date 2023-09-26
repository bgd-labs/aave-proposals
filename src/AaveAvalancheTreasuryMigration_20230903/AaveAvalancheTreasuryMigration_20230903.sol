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
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xfe17ba406d90f8308794d14e8cad4f8d44c1f74e5589a5a106f9af17df916a59
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-avalanche-v2-to-v3-migration/14469
 */
contract AaveAvalancheTreasuryMigration_20230903 is IProposalGenericExecutor {

  function execute() external {
    IMigrationHelper migrationHelper = IMigrationHelper(AaveV2Avalanche.MIGRATION_HELPER);

    address[] memory assetsToMigrate = new address[](4);
    assetsToMigrate[0] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    assetsToMigrate[1] = AaveV2AvalancheAssets.WBTCe_UNDERLYING;
    assetsToMigrate[2] = AaveV2AvalancheAssets.WETHe_UNDERLYING;
    assetsToMigrate[3] = AaveV2AvalancheAssets.WAVAX_UNDERLYING;

    IMigrationHelper.RepaySimpleInput[] memory positionsToRepay = new IMigrationHelper.RepaySimpleInput[](0);
    IMigrationHelper.PermitInput[] memory permits = new IMigrationHelper.PermitInput[](0);
    IMigrationHelper.CreditDelegationInput[] memory creditDelegationPermits = new IMigrationHelper.CreditDelegationInput[](0);

    uint256 i = 0;

    for(;i < assetsToMigrate.length;) {
        address aToken = migrationHelper.aTokens(assetsToMigrate[i]);
        uint256 amount = IERC20(aToken).balanceOf(address(AaveV2Avalanche.COLLECTOR));
        AaveV2Avalanche.COLLECTOR.transfer(aToken, address(this), amount);
        SafeERC20.forceApprove(IERC20(aToken), address(migrationHelper), amount);
        unchecked {
            ++i;
        }
    }

    migrationHelper.migrate(assetsToMigrate, positionsToRepay, permits, creditDelegationPermits);

    address[] memory newAssetsMigrated = new address[](4);
    newAssetsMigrated[0] = AaveV3AvalancheAssets.DAIe_A_TOKEN;
    newAssetsMigrated[1] = AaveV3AvalancheAssets.WBTCe_A_TOKEN;
    newAssetsMigrated[2] = AaveV3AvalancheAssets.WETHe_A_TOKEN;
    newAssetsMigrated[3] = AaveV3AvalancheAssets.WAVAX_A_TOKEN;

    for(i = 0; i < newAssetsMigrated.length;) {
        SafeERC20.safeTransfer(
            IERC20(newAssetsMigrated[i]), 
            address(AaveV3Avalanche.COLLECTOR), 
            IERC20(newAssetsMigrated[i]).balanceOf(address(this))
        );
        unchecked {
            ++i;
        }
    }
  }
}