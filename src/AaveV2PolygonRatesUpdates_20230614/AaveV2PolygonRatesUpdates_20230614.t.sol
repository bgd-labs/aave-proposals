// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PolygonRatesUpdates_20230614} from './AaveV2PolygonRatesUpdates_20230614.sol';

contract AaveV2PolygonRatesUpdates_20230614_Test is ProtocolV2TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 43914253);

    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testpayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonUpdate20230614',
      AaveV2Polygon.POOL
    );

    _executePayload(address(new AaveV2PolygonRatesUpdates_20230614()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'proTestPolygonUpdate20230614',
      AaveV2Polygon.POOL
    );

    diffReports('preTestPolygonUpdate20230614', 'proTestPolygonUpdate20230614');

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

    ReserveConfig[] memory configs = _getReservesConfigs(AaveV2Polygon.POOL);
    for (uint i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(configs, assetsChanged[i]);
      _deposit(cfg, AaveV2Polygon.POOL, address(42), 100);
    }
  }
}
