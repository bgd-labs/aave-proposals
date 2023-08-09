// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AavePolygonTreasuryMigration_20230801} from './AavePolygonTreasuryMigration_20230801.sol';

contract AavePolygonTreasuryMigration_20230801_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 45864548);
  }

  function testpayload() public {

    AavePolygonTreasuryMigration_20230801 payload = new AavePolygonTreasuryMigration_20230801();

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    address[] memory ASSETS_MIGRATED = new address[](10);
    ASSETS_MIGRATED[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    ASSETS_MIGRATED[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    ASSETS_MIGRATED[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    ASSETS_MIGRATED[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    ASSETS_MIGRATED[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    ASSETS_MIGRATED[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    ASSETS_MIGRATED[6] = AaveV2PolygonAssets.BAL_UNDERLYING;
    ASSETS_MIGRATED[7] = AaveV2PolygonAssets.CRV_UNDERLYING;
    ASSETS_MIGRATED[8] = AaveV2PolygonAssets.GHST_UNDERLYING;
    ASSETS_MIGRATED[9] = AaveV2PolygonAssets.LINK_UNDERLYING;

    // TODO make sure collector asset balances are zero
    // uint256 balanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(payload));
  }
}
