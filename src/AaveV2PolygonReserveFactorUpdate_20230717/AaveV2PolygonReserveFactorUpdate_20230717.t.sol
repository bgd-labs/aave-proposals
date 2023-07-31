// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PolygonReserveFactorUpdate_20230717} from './AaveV2PolygonReserveFactorUpdate_20230717.sol';

contract AaveV2PolygonReserveFactorUpdate_20230717_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 43981679);
  }

  function testpayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonReserveFactorUpdate20230717',
      AaveV2Polygon.POOL
    );

    AaveV2PolygonReserveFactorUpdate_20230717 payload = new AaveV2PolygonReserveFactorUpdate_20230717();

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolygonReserveFactorUpdate20230717',
      AaveV2Polygon.POOL
    );

    diffReports('preTestPolygonReserveFactorUpdate20230717', 'postTestPolygonReserveFactorUpdate20230717');

    address[] memory assetsChanged = new address[](10);
    assetsChanged[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    assetsChanged[6] = AaveV2PolygonAssets.BAL_UNDERLYING;
    assetsChanged[7] = AaveV2PolygonAssets.CRV_UNDERLYING;
    assetsChanged[8] = AaveV2PolygonAssets.GHST_UNDERLYING;
    assetsChanged[9] = AaveV2PolygonAssets.LINK_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    e2eTest(AaveV2Polygon.POOL);
  }
}
