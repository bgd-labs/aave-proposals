// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import 'forge-std/console.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3AvaxWAVAXInterestRatePayload} from '../../contracts/avalanche/AaveV3AvaxWAVAXInterestRatePayload.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IDefaultInterestRateStrategy} from 'aave-v3-core/contracts/interfaces/IDefaultInterestRateStrategy.sol';
import {DataTypes} from 'aave-v3-core/contracts/protocol/libraries/types/DataTypes.sol';

contract AaveV3AvaxWAVAXInterestRatePayloadTest is ProtocolV3TestBase, TestWithExecutor {
  address internal constant AVAX_GUARDIAN = 0xa35b76E4935449E33C56aB24b23fcd3246f13470;
  uint256 internal constant RAY = 1e27;
  uint256 public proposalId;
  AaveV3AvaxWAVAXInterestRatePayload public payload;

  // Old Strategy
  IDefaultInterestRateStrategy public constant OLD_INTEREST_RATE_STRATEGY =
    IDefaultInterestRateStrategy(AaveV3AvalancheAssets.WAVAX_INTEREST_RATE_STRATEGY);

  // New Strategy
  IDefaultInterestRateStrategy public strategy;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 27701185);
    _selectPayloadExecutor(AVAX_GUARDIAN);

    payload = new AaveV3AvaxWAVAXInterestRatePayload();
    strategy = IDefaultInterestRateStrategy(payload.INTEREST_RATE_STRATEGY());
  }

  function testExecuteValidation() public {
    createConfigurationSnapshot('pre-AaveV3Avalanche-interestRateUpdate', AaveV3Avalanche.POOL);

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Avalanche.POOL);
    ReserveConfig memory wavax = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.WAVAX_UNDERLYING
    );
    wavax.interestRateStrategy = payload.INTEREST_RATE_STRATEGY();

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Avalanche.POOL);

    _validateReserveConfig(wavax, allConfigs);

    _validateInterestRateStrategy(
      _findReserveConfig(allConfigs, AaveV3AvalancheAssets.WAVAX_UNDERLYING).interestRateStrategy,
      payload.INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV3Avalanche.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 65 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 872 * (RAY / 10000),
        stableRateSlope1: 472 * (RAY / 10000),
        stableRateSlope2: 14428 * (RAY / 10000),
        baseVariableBorrowRate: 1 * (RAY / 100),
        variableRateSlope1: 472 * (RAY / 10000),
        variableRateSlope2: 14428 * (RAY / 10000)
      })
    );

    createConfigurationSnapshot('post-AaveV3Avalanche-interestRateUpdate', AaveV3Avalanche.POOL);

    diffReports(
      'pre-AaveV3Avalanche-interestRateUpdate',
      'post-AaveV3Avalanche-interestRateUpdate'
    );
  }

  // Interest Strategy
  function testUtilizationAtZeroPercent() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 10e18,
      liquidityTaken: 0,
      totalStableDebt: 0,
      totalVariableDebt: 0,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      aToken: AaveV3AvalancheAssets.WAVAX_A_TOKEN
    });
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    assertEq(liqRate, 0);
    assertEq(stableRate, 872 * (RAY / 10000));
    assertEq(varRate, 1 * (RAY / 100));
  }

  function testUtilizationAtOneHundredPercent() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 0,
      liquidityTaken: 1720318038436417522869998,
      totalStableDebt: 0,
      totalVariableDebt: 5e18,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      aToken: AaveV3AvalancheAssets.WAVAX_A_TOKEN
    });
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    assertEq(liqRate, 1200000000000000000000000000);
    assertEq(stableRate, 15772 * (RAY / 10000));
    assertEq(varRate, 150 * (RAY / 100));
  }

  function testUtilizationAtUOptimal() public {
    DataTypes.CalculateInterestRatesParams memory params = DataTypes.CalculateInterestRatesParams({
      unbacked: 0,
      liquidityAdded: 79681961563582477130002,
      liquidityTaken: 1170000000000000000000000,
      totalStableDebt: 0,
      totalVariableDebt: 1170000000000000000000000,
      averageStableBorrowRate: 0,
      reserveFactor: 2000,
      reserve: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
      aToken: AaveV3AvalancheAssets.WAVAX_A_TOKEN
    });

    console.log(
      IERC20(AaveV3AvalancheAssets.WAVAX_UNDERLYING).balanceOf(AaveV3AvalancheAssets.WAVAX_A_TOKEN)
    );

    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      params
    );

    assertEq(liqRate, 29744000000000000000000000);
    assertEq(stableRate, 1344 * (RAY / 10000));
    assertEq(varRate, 572 * (RAY / 10000));
  }
}
