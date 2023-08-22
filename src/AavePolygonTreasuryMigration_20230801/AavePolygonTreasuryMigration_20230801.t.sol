// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AavePolygonTreasuryMigration_20230801} from './AavePolygonTreasuryMigration_20230801.sol';

contract AavePolygonTreasuryMigration_20230801_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46619160);
  }

  function testpayload() public {
    address[] memory OLD_ASSETS_MIGRATED = new address[](10);
    OLD_ASSETS_MIGRATED[0] = AaveV2PolygonAssets.DAI_A_TOKEN;
    OLD_ASSETS_MIGRATED[1] = AaveV2PolygonAssets.USDC_A_TOKEN;
    OLD_ASSETS_MIGRATED[2] = AaveV2PolygonAssets.USDT_A_TOKEN;
    OLD_ASSETS_MIGRATED[3] = AaveV2PolygonAssets.WBTC_A_TOKEN;
    OLD_ASSETS_MIGRATED[4] = AaveV2PolygonAssets.WETH_A_TOKEN;
    OLD_ASSETS_MIGRATED[5] = AaveV2PolygonAssets.WMATIC_A_TOKEN;
    OLD_ASSETS_MIGRATED[6] = AaveV2PolygonAssets.BAL_A_TOKEN;
    OLD_ASSETS_MIGRATED[7] = AaveV2PolygonAssets.CRV_A_TOKEN;
    OLD_ASSETS_MIGRATED[8] = AaveV2PolygonAssets.GHST_A_TOKEN;
    OLD_ASSETS_MIGRATED[9] = AaveV2PolygonAssets.LINK_A_TOKEN;

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

    uint256[] memory NEW_ASSETS_BEFORE_BALANCE = new uint256[](10);
    uint256[] memory OLD_ASSETS_BEFORE_BALANCE = new uint256[](10);

    uint256 i = 0;
    uint256 payloadBalanceAfter;
    uint256 collectorBalanceAfter;

    for(; i < NEW_ASSETS_MIGRATED.length; i++) {
      NEW_ASSETS_BEFORE_BALANCE[i] = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));
      OLD_ASSETS_BEFORE_BALANCE[i] = IERC20(OLD_ASSETS_MIGRATED[i]).balanceOf(address(AaveV2Polygon.COLLECTOR));
    }

    AavePolygonTreasuryMigration_20230801 payload = AavePolygonTreasuryMigration_20230801(0xC34A9391c08b64C4A9167D9e1E884B3735Ce21b0);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    for(i = 0; i < OLD_ASSETS_MIGRATED.length; i++) {
      payloadBalanceAfter = IERC20(OLD_ASSETS_MIGRATED[i]).balanceOf(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
      assertEq(payloadBalanceAfter, 0);
    }

    for(i = 0; i < NEW_ASSETS_MIGRATED.length; i++) {
      payloadBalanceAfter = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR));
      assertEq(payloadBalanceAfter, 0);
      collectorBalanceAfter = IERC20(NEW_ASSETS_MIGRATED[i]).balanceOf(address(AaveV3Polygon.COLLECTOR));
      /// 0.001e18 is 0.1%
      assertApproxEqRel(NEW_ASSETS_BEFORE_BALANCE[i] + OLD_ASSETS_BEFORE_BALANCE[i], collectorBalanceAfter, 0.001e18);
    }
  }
}
