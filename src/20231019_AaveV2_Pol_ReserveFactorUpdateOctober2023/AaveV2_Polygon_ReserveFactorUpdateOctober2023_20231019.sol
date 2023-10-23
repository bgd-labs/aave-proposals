// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title Reserve Factor Update October 2023
 * @author TokenLogic
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/8
 */
contract AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019 is IProposalGenericExecutor {
  function execute() external {
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, 41_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, 43_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, 42_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WBTC_UNDERLYING, 75_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WETH_UNDERLYING, 65_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.WMATIC_UNDERLYING, 61_00);
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(AaveV2PolygonAssets.BAL_UNDERLYING, 52_00);
  }
}
