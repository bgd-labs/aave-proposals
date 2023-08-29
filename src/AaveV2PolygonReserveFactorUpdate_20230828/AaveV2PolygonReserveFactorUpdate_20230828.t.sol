// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PolygonReserveFactorUpdate_20230828} from './AaveV2PolygonReserveFactorUpdate_20230828.sol';

contract AaveV2PolygonReserveFactorUpdate_20230828_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46835810);
  }

  function testpayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonReserveFactorUpdate20230828',
      AaveV2Polygon.POOL
    );

    AaveV2PolygonReserveFactorUpdate_20230828 payload = new AaveV2PolygonReserveFactorUpdate_20230828();

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolygonReserveFactorUpdate20230828',
      AaveV2Polygon.POOL
    );

    diffReports('preTestPolygonReserveFactorUpdate20230828', 'postTestPolygonReserveFactorUpdate20230828');

    address[] memory assetsChanged = new address[](10);
    assetsChanged[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    assetsChanged[6] = AaveV2PolygonAssets.BAL_UNDERLYING;

    ReserveConfig memory DAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.DAI_UNDERLYING
    );
    DAI_UNDERLYING_CONFIG.reserveFactor = 31_00;
    _validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.USDC_UNDERLYING
    );
    USDC_UNDERLYING_CONFIG.reserveFactor = 33_00;
    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory USDT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.USDT_UNDERLYING
    );
    USDT_UNDERLYING_CONFIG.reserveFactor = 32_00;
    _validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory WBTC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.WBTC_UNDERLYING
    );
    WBTC_UNDERLYING_CONFIG.reserveFactor = 65_00;
    _validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory WETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.WETH_UNDERLYING
    );
    WETH_UNDERLYING_CONFIG.reserveFactor = 55_00;
    _validateReserveConfig(WETH_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory WMATIC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.WMATIC_UNDERLYING
    );
    WMATIC_UNDERLYING_CONFIG.reserveFactor = 51_00;
    _validateReserveConfig(WMATIC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2PolygonAssets.BAL_UNDERLYING
    );
    BAL_UNDERLYING_CONFIG.reserveFactor = 42_00;
    _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    e2eTest(AaveV2Polygon.POOL);
  }
}
