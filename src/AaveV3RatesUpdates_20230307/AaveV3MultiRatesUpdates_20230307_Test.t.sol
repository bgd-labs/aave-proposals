// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbRatesUpdates_20230307} from './AaveV3ArbRatesUpdates_20230307.sol';
import {AaveV3PolRatesUpdates_20230307} from './AaveV3PolRatesUpdates_20230307.sol';
import {AaveV3OptRatesUpdates_20230307} from './AaveV3OptRatesUpdates_20230307.sol';

/// @dev Assuming that rates, as they use the RATES_FACTORY have correct code, so verification via
/// diff reports is enough
contract AaveV3PolRatesUpdates_20230307_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40098990);

    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolRatesUpdateMar7',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory usdtBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.USDT_UNDERLYING
    );

    ReserveConfig memory eursBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.EURS_UNDERLYING
    );

    ReserveConfig memory maiBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.miMATIC_UNDERLYING
    );

    ReserveConfig memory ageurBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.agEUR_UNDERLYING
    );

    ReserveConfig memory wethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WETH_UNDERLYING
    );
    ReserveConfig memory ghstBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.GHST_UNDERLYING
    );
    ReserveConfig memory dpiBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.DPI_UNDERLYING
    );

    _executePayload(address(new AaveV3PolRatesUpdates_20230307()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolRatesUpdateMar7',
      AaveV3Polygon.POOL
    );

    diffReports('preTestPolRatesUpdateMar7', 'postTestPolRatesUpdateMar7');

    address[] memory assetsChanged = new address[](7);
    assetsChanged[0] = AaveV3PolygonAssets.USDT_UNDERLYING;
    assetsChanged[1] = AaveV3PolygonAssets.EURS_UNDERLYING;
    assetsChanged[2] = AaveV3PolygonAssets.miMATIC_UNDERLYING;
    assetsChanged[3] = AaveV3PolygonAssets.agEUR_UNDERLYING;
    assetsChanged[4] = AaveV3PolygonAssets.WETH_UNDERLYING;
    assetsChanged[5] = AaveV3PolygonAssets.GHST_UNDERLYING;
    assetsChanged[6] = AaveV3PolygonAssets.DPI_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory usdtAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.USDT_UNDERLYING
      );
      usdtBefore.interestRateStrategy = usdtAfter.interestRateStrategy;
      _validateReserveConfig(usdtBefore, allConfigsAfter);
      _logStrategyPreviewUrlParams(usdtAfter);
    }

    {
      ReserveConfig memory eursAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.EURS_UNDERLYING
      );
      eursBefore.interestRateStrategy = eursAfter.interestRateStrategy;
      _validateReserveConfig(eursBefore, allConfigsAfter);
      _logStrategyPreviewUrlParams(eursAfter);
    }

    {
      ReserveConfig memory maiAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.miMATIC_UNDERLYING
      );
      maiBefore.interestRateStrategy = maiAfter.interestRateStrategy;
      maiBefore.reserveFactor = 20_00;
      _validateReserveConfig(maiBefore, allConfigsAfter);
      _logStrategyPreviewUrlParams(maiAfter);
    }

    {
      ReserveConfig memory ageurAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.agEUR_UNDERLYING
      );
      ageurBefore.interestRateStrategy = ageurAfter.interestRateStrategy;
      _validateReserveConfig(ageurBefore, allConfigsAfter);
      _logStrategyPreviewUrlParams(ageurAfter);
    }
    {
      ReserveConfig memory wethAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.WETH_UNDERLYING
      );
      wethBefore.interestRateStrategy = wethAfter.interestRateStrategy;
      wethBefore.reserveFactor = 15_00;
      _validateReserveConfig(wethBefore, allConfigsAfter);
      _logStrategyPreviewUrlParams(wethAfter);
    }

    {
      ReserveConfig memory ghstAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.GHST_UNDERLYING
      );
      ghstBefore.interestRateStrategy = ghstAfter.interestRateStrategy;
      ghstBefore.reserveFactor = 35_00;
      _validateReserveConfig(ghstBefore, allConfigsAfter);
    }
    {
      ReserveConfig memory dpiAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.DPI_UNDERLYING
      );
      dpiBefore.interestRateStrategy = dpiAfter.interestRateStrategy;
      dpiBefore.reserveFactor = 35_00;
      _validateReserveConfig(dpiBefore, allConfigsAfter);
    }
  }
}

contract AaveV3OptRatesUpdates_20230307_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 79218113);

    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestOptRatesUpdateMar7',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory usdtBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.USDT_UNDERLYING
    );

    ReserveConfig memory wethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WETH_UNDERLYING
    );

    _executePayload(address(new AaveV3OptRatesUpdates_20230307()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestOptRatesUpdateMar7',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory usdtAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3OptimismAssets.USDT_UNDERLYING
    );

    ReserveConfig memory wethAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3OptimismAssets.WETH_UNDERLYING
    );

    diffReports('preTestOptRatesUpdateMar7', 'postTestOptRatesUpdateMar7');

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3OptimismAssets.USDT_UNDERLYING;
    assetsChanged[1] = AaveV3OptimismAssets.WETH_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    usdtBefore.interestRateStrategy = usdtAfter.interestRateStrategy;

    wethBefore.interestRateStrategy = wethAfter.interestRateStrategy;
    wethBefore.reserveFactor = 15_00;

    _validateReserveConfig(usdtBefore, allConfigsAfter);
    _validateReserveConfig(wethBefore, allConfigsAfter);

    _logStrategyPreviewUrlParams(usdtAfter);
    _logStrategyPreviewUrlParams(wethAfter);
  }
}

contract AaveV3ArbRatesUpdates_20230307_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 74573291);

    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testNewChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbRatesUpdateMar7',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory usdtBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.USDT_UNDERLYING
    );

    ReserveConfig memory eursBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.EURS_UNDERLYING
    );

    ReserveConfig memory wethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );

    _executePayload(address(new AaveV3ArbRatesUpdates_20230307()));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestArbRatesUpdateMar7',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory usdtAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3ArbitrumAssets.USDT_UNDERLYING
    );

    ReserveConfig memory eursAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3ArbitrumAssets.EURS_UNDERLYING
    );

    ReserveConfig memory wethAfter = _findReserveConfig(
      allConfigsAfter,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );

    diffReports('preTestArbRatesUpdateMar7', 'postTestArbRatesUpdateMar7');

    address[] memory assetsChanged = new address[](3);
    assetsChanged[0] = AaveV3ArbitrumAssets.USDT_UNDERLYING;
    assetsChanged[1] = AaveV3ArbitrumAssets.EURS_UNDERLYING;
    assetsChanged[2] = AaveV3ArbitrumAssets.WETH_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    usdtBefore.interestRateStrategy = usdtAfter.interestRateStrategy;

    eursBefore.interestRateStrategy = eursAfter.interestRateStrategy;

    wethBefore.interestRateStrategy = wethAfter.interestRateStrategy;
    wethBefore.reserveFactor = 15_00;

    _validateReserveConfig(usdtBefore, allConfigsAfter);
    _validateReserveConfig(eursBefore, allConfigsAfter);
    _validateReserveConfig(wethBefore, allConfigsAfter);

    _logStrategyPreviewUrlParams(usdtAfter);
    _logStrategyPreviewUrlParams(eursAfter);
    _logStrategyPreviewUrlParams(wethAfter);
  }
}
