// SPDX-License-Identifier: MIT

/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/

pragma solidity ^0.8.0;

import 'aave-helpers/v2-config-engine/AaveV2PayloadPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @dev Encourage Polygon v2 users to migrate to v3 by updating Uoptimal, Reserve Factor and Slope2 paramters on Polygon v2.
 * @author defijesus.eth - TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x013f763e92d253926bc7f04d79138593a1b31c969a34db7f0955e46850c796d9
 * - Discussion: https://governance.aave.com/t/arfc-polygon-v2-parameter-update/12817
 */
contract AaveV2PolygonRatesUpdates_20230614 is AaveV2PayloadPolygon {

  function _postExecute() internal override {
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, 21_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, 23_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, 22_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WBTC_UNDERLYING, 55_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WETH_UNDERLYING, 45_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WMATIC_UNDERLYING, 41_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.BAL_UNDERLYING, 32_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.CRV_UNDERLYING, 38_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.GHST_UNDERLYING, 60_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.LINK_UNDERLYING, 50_00);
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
        optimalUtilizationRate: _bpsToRay(71_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(105_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(105_00)
      })
    });

    rateStrategy[1] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.USDC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(77_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(134_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(134_00)
      })
    });

    rateStrategy[2] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.USDT_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(52_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(236_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(236_00)
      })
    });

    rateStrategy[3] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WBTC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(37_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(536_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(536_00)
      })
    });

    rateStrategy[4] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(40_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(167_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(167_00)
      })
    });

    rateStrategy[5] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WMATIC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(48_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(440_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(440_00)
      })
    });

    rateStrategy[6] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.BAL_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(65_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(236_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: _bpsToRay(236_00)
      })
    });

    rateStrategy[7] = IEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.CRV_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
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