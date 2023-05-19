// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PolygonIR_20230519} from './AaveV2PolygonIR_20230519.sol';

contract AaveV2PolygonIR_20230519_Test is ProtocolV2TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42894947);

    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testpayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonUpdate20230507',
      AaveV2Polygon.POOL
    );

    _executePayload(address(new AaveV2PolygonIR_20230519()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolygonUpdate20230507',
      AaveV2Polygon.POOL
    );

    diffReports('preTestPolygonUpdate20230507', 'postTestPolygonUpdate20230507');

    address[] memory assetsChanged = new address[](4);
    assetsChanged[0] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig[] memory configs = _getReservesConfigs(AaveV2Polygon.POOL);
    for (uint i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory cfg = _findReserveConfig(configs, assetsChanged[i]);
      _deposit(cfg, AaveV2Polygon.POOL, address(42), 100);
    }
  }
}
