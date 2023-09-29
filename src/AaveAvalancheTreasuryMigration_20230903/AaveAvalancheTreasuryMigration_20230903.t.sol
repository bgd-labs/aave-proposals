// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveAvalancheTreasuryMigration_20230903} from './AaveAvalancheTreasuryMigration_20230903.sol';

contract AaveAvalancheTreasuryMigration_20230903_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 35644766);
  }

  function testPayload() public {
    address[4] memory oldAssetsMigrated;
    oldAssetsMigrated[0] = AaveV2AvalancheAssets.DAIe_A_TOKEN;
    oldAssetsMigrated[1] = AaveV2AvalancheAssets.WBTCe_A_TOKEN;
    oldAssetsMigrated[2] = AaveV2AvalancheAssets.WETHe_A_TOKEN;
    oldAssetsMigrated[3] = AaveV2AvalancheAssets.WAVAX_A_TOKEN;

    address[4] memory newAssetsMigrated;
    newAssetsMigrated[0] = AaveV3AvalancheAssets.DAIe_A_TOKEN;
    newAssetsMigrated[1] = AaveV3AvalancheAssets.WBTCe_A_TOKEN;
    newAssetsMigrated[2] = AaveV3AvalancheAssets.WETHe_A_TOKEN;
    newAssetsMigrated[3] = AaveV3AvalancheAssets.WAVAX_A_TOKEN;

    uint256[4] memory newAssetsBeforeBalance;
    uint256[4] memory oldAssetsBeforeBalance;

    uint256 executorBalanceAfter;
    uint256 collectorBalanceAfter;

    for(uint256 i = 0; i < newAssetsMigrated.length; i++) {
      newAssetsBeforeBalance[i] = IERC20(newAssetsMigrated[i]).balanceOf(address(AaveV3Avalanche.COLLECTOR));
      oldAssetsBeforeBalance[i] = IERC20(oldAssetsMigrated[i]).balanceOf(address(AaveV2Avalanche.COLLECTOR));
    }

    AaveAvalancheTreasuryMigration_20230903 payload = AaveAvalancheTreasuryMigration_20230903(0x2DD58BeDC4A91110Bf9aF1d2bc3f13966d1C6643);

    GovHelpers.executePayload(vm, address(payload), AaveV3Avalanche.ACL_ADMIN);

    for(uint256 i = 0; i < oldAssetsMigrated.length; i++) {
      executorBalanceAfter = IERC20(oldAssetsMigrated[i]).balanceOf(AaveV3Avalanche.ACL_ADMIN);
      assertEq(executorBalanceAfter, 0);
      executorBalanceAfter = IERC20(newAssetsMigrated[i]).balanceOf(AaveV3Avalanche.ACL_ADMIN);
      assertEq(executorBalanceAfter, 0);
    }

    for(uint256 i = 0; i < newAssetsMigrated.length; i++) {
      collectorBalanceAfter = IERC20(newAssetsMigrated[i]).balanceOf(address(AaveV3Avalanche.COLLECTOR));
      /// 0.001e18 is 0.1%
      assertApproxEqRel(newAssetsBeforeBalance[i] + oldAssetsBeforeBalance[i], collectorBalanceAfter, 0.001e18);
    }
  }
}
