// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/v2-config-engine/AaveV2PayloadPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @dev Smart contract for a mock rates update, for testing purposes
 * IMPORTANT Parameters are pseudo-random, DON'T USE THIS ANYHOW IN PRODUCTION
 * @author BGD Labs
 */
contract AaveV2PolygonRatesUpdates_20230614 is AaveV2PayloadPolygon {
  ILendingPoolConfigurator internal configurator = ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR);

  function _postExecute() internal override {
    configurator.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, 33_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, 21_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, 27_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.WBTC_UNDERLYING, 57_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.WETH_UNDERLYING, 51_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.WMATIC_UNDERLYING, 38_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.BAL_UNDERLYING, 32_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.CRV_UNDERLYING, 37_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.GHST_UNDERLYING, 60_00);
    configurator.setReserveFactor(AaveV2PolygonAssets.LINK_UNDERLYING, 50_00);
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IEngine.RateStrategyUpdate[] memory)
  {
    IEngine.RateStrategyUpdate[] memory rateStrategy = new IEngine.RateStrategyUpdate[](10);

    rateStrategy[0] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.DAI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(60_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(146_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(146_00)
      })
    });

    rateStrategy[1] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.USDC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(79_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(122_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(122_00)
      })
    });

    rateStrategy[2] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.USDT_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(84_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(92_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(92_00)
      })
    });

    rateStrategy[3] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WBTC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(35_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(549_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(549_00)
      })
    });

    rateStrategy[4] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(38_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(175_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(175_00)
      })
    });

    rateStrategy[5] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WMATIC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(35_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(111_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(111_00)
      })
    });

    rateStrategy[6] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.BAL_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(65_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(246_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(246_00)
      })
    });

    rateStrategy[7] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.CRV_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(26_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(392_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(392_00)
      })
    });

    rateStrategy[8] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.GHST_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(23_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(413_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(413_00)
      })
    });

    rateStrategy[9] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.LINK_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(402_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(402_00)
      })
    });

    return rateStrategy;
  }
}