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
    vm.createSelectFork(vm.rpcUrl('avalanche'), 35177276);
  }

  function testPayload() public {
    address[] memory OLD_ASSETS_MIGRATED = new address[](6);
    OLD_ASSETS_MIGRATED[0] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    OLD_ASSETS_MIGRATED[1] = AaveV2AvalancheAssets.USDCe_UNDERLYING;
    OLD_ASSETS_MIGRATED[2] = AaveV2AvalancheAssets.USDTe_UNDERLYING;
    OLD_ASSETS_MIGRATED[3] = AaveV2AvalancheAssets.WBTCe_UNDERLYING;
    OLD_ASSETS_MIGRATED[4] = AaveV2AvalancheAssets.WETHe_UNDERLYING;
    OLD_ASSETS_MIGRATED[5] = AaveV2AvalancheAssets.WAVAX_UNDERLYING;

    address[] memory NEW_ASSETS_MIGRATED = new address[](6);
    NEW_ASSETS_MIGRATED[0] = AaveV3AvalancheAssets.DAIe_A_TOKEN;
    NEW_ASSETS_MIGRATED[1] = AaveV3AvalancheAssets.USDC_A_TOKEN;
    NEW_ASSETS_MIGRATED[2] = AaveV3AvalancheAssets.USDt_A_TOKEN;
    NEW_ASSETS_MIGRATED[3] = AaveV3AvalancheAssets.WBTCe_A_TOKEN;
    NEW_ASSETS_MIGRATED[4] = AaveV3AvalancheAssets.WETHe_A_TOKEN;
    NEW_ASSETS_MIGRATED[5] = AaveV3AvalancheAssets.WAVAX_A_TOKEN;

    uint256[] memory NEW_ASSETS_BEFORE_BALANCE = new uint256[](6);
    uint256[] memory OLD_ASSETS_BEFORE_BALANCE = new uint256[](6);

    uint256 i = 0;
    uint256 payloadBalanceAfter;
    uint256 collectorBalanceAfter;

    for(; i < NEW_ASSETS_MIGRATED.length; i++) {
      NEW_ASSETS_BEFORE_BALANCE[i] = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(AaveV3Avalanche.COLLECTOR));
      OLD_ASSETS_BEFORE_BALANCE[i] = IERC20(OLD_ASSETS_MIGRATED[i]).balanceOf(address(AaveV2Avalanche.COLLECTOR));
    }

    AaveAvalancheTreasuryMigration_20230903 payload = new AaveAvalancheTreasuryMigration_20230903();

    GovHelpers.executePayload(vm, address(payload), AaveV3Avalanche.ACL_ADMIN);

    for(i = 0; i < OLD_ASSETS_MIGRATED.length; i++) {
      payloadBalanceAfter = IERC20(OLD_ASSETS_MIGRATED[i]).balanceOf(address(payload));
      assertEq(payloadBalanceAfter, 0);
    }

    for(i = 0; i < NEW_ASSETS_MIGRATED.length; i++) {
      payloadBalanceAfter = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(payload));
      assertEq(payloadBalanceAfter, 0);
      collectorBalanceAfter = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(AaveV3Avalanche.COLLECTOR));
      /// 0.001e18 is 0.1%
      assertApproxEqRel(NEW_ASSETS_BEFORE_BALANCE[i] + OLD_ASSETS_BEFORE_BALANCE[i], collectorBalanceAfter, 0.001e18);
    }
  }
}
