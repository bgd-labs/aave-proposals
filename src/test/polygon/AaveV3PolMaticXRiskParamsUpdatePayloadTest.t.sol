// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import 'forge-std/console.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolMaticXRiskParamsUpdatePayload} from '../../contracts/polygon/AaveV3PolMaticXRiskParamsUpdatePayload.sol';
import {IDefaultInterestRateStrategy} from 'aave-v3/interfaces/IDefaultInterestRateStrategy.sol';
import {DataTypes} from 'aave-v3/protocol/libraries/types/DataTypes.sol';

contract AaveV3PolMaticXRiskParamsUpdatePayloadTest is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3PolMaticXRiskParamsUpdatePayload public payload;
  IDefaultInterestRateStrategy public strategy;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39552462);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    payload = new AaveV3PolMaticXRiskParamsUpdatePayload();
    strategy = IDefaultInterestRateStrategy(payload.NEW_INTEREST_RATE_STRATEGY());
  }

  function testExecute() public {
    createConfigurationSnapshot(
      'pre-MaticX-Aave-V3-Polygon-Risk-Param-Updates',
      AaveV3Polygon.POOL
    );

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);
    ReserveConfig memory maticx = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Polygon.POOL);

    ReserveConfig memory expectedConfig = ReserveConfig({
      symbol: maticx.symbol,
      underlying: AaveV3PolygonAssets.MaticX_UNDERLYING,
      aToken: maticx.aToken,
      variableDebtToken: maticx.variableDebtToken,
      stableDebtToken: maticx.stableDebtToken,
      decimals: maticx.decimals,
      ltv: payload.NEW_LTV(),
      liquidationThreshold: payload.NEW_LIQ_THRESHOLD(),
      liquidationBonus: payload.NEW_LIQ_BONUS(),
      liquidationProtocolFee: payload.NEW_LIQ_FEE(),
      reserveFactor: maticx.reserveFactor,
      usageAsCollateralEnabled: maticx.usageAsCollateralEnabled,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfig(allConfigs, AaveV3PolygonAssets.MaticX_UNDERLYING)
        .interestRateStrategy,
      stableBorrowRateEnabled: maticx.stableBorrowRateEnabled,
      isActive: maticx.isActive,
      isFrozen: maticx.isFrozen,
      isSiloed: maticx.isSiloed,
      isBorrowableInIsolation: maticx.isBorrowableInIsolation,
      isFlashloanable: maticx.isFlashloanable,
      supplyCap: payload.NEW_SUPPLY_CAP(),
      borrowCap: payload.NEW_BORROW_CAP(),
      debtCeiling: maticx.debtCeiling,
      eModeCategory: maticx.eModeCategory
    });

    _validateReserveConfig(expectedConfig, allConfigs);

    _validateInterestRateStrategy(
      expectedConfig.interestRateStrategy,
      payload.NEW_INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV3Polygon.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 6 * (RAY / 100),
        stableRateSlope1: 50 * (RAY / 10000),
        stableRateSlope2: 150 * (RAY / 100),
        baseVariableBorrowRate: 25 * (RAY / 10000),
        variableRateSlope1: 4 * (RAY / 100),
        variableRateSlope2: 150 * (RAY / 100)
      })
    );

    createConfigurationSnapshot(
      'post-MaticX-Aave-V3-Polygon-Risk-Param-Updates',
      AaveV3Polygon.POOL
    );

    diffReports(
      'pre-MaticX-Aave-V3-Polygon-Risk-Param-Updates',
      'post-MaticX-Aave-V3-Polygon-Risk-Param-Updates'
    );
  }

  function testUtilizationAtZeroPercentMaticX() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 10e18,
      liquidityTaken: 0,
      totalStableDebt: 0,
      totalVariableDebt: 0,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3PolygonAssets.MaticX_UNDERLYING,
      aToken: AaveV3PolygonAssets.MaticX_A_TOKEN
    });
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    // At nothing borrowed, liquidity rate should be 0, variable rate should be 0.25% and stable rate should be 6%.
    assertEq(liqRate, 0);
    assertEq(stableRate, 6 * (RAY / 100));
    assertEq(varRate, 25 * (RAY / 10000));
  }

  function testUtilizationAtOneHundredPercentMaticX() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 0,
      liquidityTaken: 5994446301359038315297454,
      totalStableDebt: 0,
      totalVariableDebt: 5e18,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3PolygonAssets.MaticX_UNDERLYING,
      aToken: AaveV3PolygonAssets.MaticX_A_TOKEN
    });
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    // At 100% borrowed, variable rate should be 154.25% and stable rate should be 156%.
    assertEq(liqRate, 1234000000000000000000000000);
    assertEq(stableRate, 15650 * (RAY / 10000));
    assertEq(varRate, 15425 * (RAY / 10000));
  }

  function testUtilizationAtUOptimalMaticX() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 5553698640961684702546,
      liquidityTaken: 2700000000000000000000000,
      totalStableDebt: 0,
      totalVariableDebt: 2700000000000000000000000,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3PolygonAssets.MaticX_UNDERLYING,
      aToken: AaveV3PolygonAssets.MaticX_A_TOKEN
    });
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    // At UOptimal borrowed, variable rate should be 4.25% and stable rate should be 16%.
    assertEq(liqRate, 15300000000000000000000000);
    assertEq(stableRate, 650 * (RAY / 10000));
    assertEq(varRate, 425 * (RAY / 10000));
  }
}
