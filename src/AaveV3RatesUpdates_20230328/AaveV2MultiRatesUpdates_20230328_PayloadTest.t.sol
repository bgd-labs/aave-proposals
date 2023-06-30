// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.15;

// testing libraries
import 'forge-std/Test.sol';
import 'forge-std/console.sol';

// contract dependencies
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2EthRatesUpdates_20230328_Payload} from './AaveV2EthRatesUpdates_20230328_Payload.sol';
import {AaveV2PolRatesUpdates_20230328_Payload} from './AaveV2PolRatesUpdates_20230328_Payload.sol';
import {ProtocolV2TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

contract AaveV2MultiRatesUpdates_20230328_PayloadTest is ProtocolV2TestBase {
  uint256 internal constant RAY = 1e27;
  uint256 public mainnetFork;
  uint256 public polygonFork;
  uint256 public proposalId;
  AaveV2PolRatesUpdates_20230328_Payload public proposalPayloadPolygon;
  AaveV2EthRatesUpdates_20230328_Payload public proposalPayload;

  // Old Strategies
  IDefaultInterestRateStrategy public constant OLD_INTEREST_RATE_STRATEGY_POLYGON =
    IDefaultInterestRateStrategy(AaveV2PolygonAssets.BAL_INTEREST_RATE_STRATEGY);
  IDefaultInterestRateStrategy public constant OLD_INTEREST_RATE_STRATEGY_ETHEREUM =
    IDefaultInterestRateStrategy(AaveV2EthereumAssets.BAL_INTEREST_RATE_STRATEGY);

  // New Strategies
  address public NEW_INTEREST_RATE_STRATEGY_ETHEREUM;
  address public NEW_INTEREST_RATE_STRATEGY_POLYGON;

  // Underlying
  address public constant BAL = AaveV2EthereumAssets.BAL_UNDERLYING;
  address public constant BAL_POLYGON = AaveV2PolygonAssets.BAL_UNDERLYING;

  // New Strategies
  IDefaultInterestRateStrategy public strategy;
  IDefaultInterestRateStrategy public strategyPolygon;

  function setUp() public {
    mainnetFork = vm.createFork(vm.rpcUrl('mainnet'), 17020741);
    polygonFork = vm.createFork(vm.rpcUrl('polygon'), 41383971);

    // Deploy Payloads
    vm.selectFork(polygonFork);
    proposalPayloadPolygon = new AaveV2PolRatesUpdates_20230328_Payload();
    NEW_INTEREST_RATE_STRATEGY_POLYGON = proposalPayloadPolygon.INTEREST_RATE_STRATEGY();
    strategyPolygon = IDefaultInterestRateStrategy(NEW_INTEREST_RATE_STRATEGY_POLYGON);

    vm.selectFork(mainnetFork);
    proposalPayload = new AaveV2EthRatesUpdates_20230328_Payload();
    NEW_INTEREST_RATE_STRATEGY_ETHEREUM = proposalPayload.INTEREST_RATE_STRATEGY();
    strategy = IDefaultInterestRateStrategy(NEW_INTEREST_RATE_STRATEGY_ETHEREUM);
  }

  function testExecuteValidateEthereum() public {
    vm.selectFork(mainnetFork);
    ReserveConfig[] memory allConfigsEthereum = createConfigurationSnapshot(
      'pre-AaveV2Ethereum-interestRateUpdate-20230828',
      AaveV2Ethereum.POOL
    );
    ReserveConfig memory expectedConfig = _findReserveConfig(
      allConfigsEthereum,
      AaveV2EthereumAssets.BAL_UNDERLYING
    );
    expectedConfig.interestRateStrategy = proposalPayload.INTEREST_RATE_STRATEGY();

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // Post-execution assertations

    ReserveConfig[] memory allConfigsAfterEthereum = createConfigurationSnapshot(
      'post-AaveV2Ethereum-interestRateUpdate-20230828',
      AaveV2Ethereum.POOL
    );

    _validateReserveConfig(expectedConfig, allConfigsAfterEthereum);

    _validateInterestRateStrategy(
      _findReserveConfigBySymbol(allConfigsAfterEthereum, 'BAL').interestRateStrategy,
      AaveV2EthRatesUpdates_20230328_Payload(proposalPayload).INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        baseVariableBorrowRate: 5 * (RAY / 100),
        stableRateSlope1: 22 * (RAY / 100),
        stableRateSlope2: 150 * (RAY / 100),
        variableRateSlope1: 22 * (RAY / 100),
        variableRateSlope2: 150 * (RAY / 100)
      })
    );

    diffReports(
      'pre-AaveV2Ethereum-interestRateUpdate-20230828',
      'post-AaveV2Ethereum-interestRateUpdate-20230828'
    );
  }

  function testExecuteValidatePolygonV2() public {
    vm.selectFork(polygonFork);
    ReserveConfig[] memory allConfigsPolygon = createConfigurationSnapshot(
      'pre-AaveV2Polygon-interestRateUpdate-20230828',
      AaveV2Polygon.POOL
    );
    ReserveConfig memory expectedConfigPolygon = _findReserveConfig(
      allConfigsPolygon,
      AaveV2PolygonAssets.BAL_UNDERLYING
    );
    expectedConfigPolygon.interestRateStrategy = proposalPayloadPolygon.INTEREST_RATE_STRATEGY();

    GovHelpers.executePayload(
      vm,
      address(proposalPayloadPolygon),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfterPolygon = createConfigurationSnapshot(
      'post-AaveV2Polygon-interestRateUpdate-20230828',
      AaveV2Polygon.POOL
    );

    _validateReserveConfig(expectedConfigPolygon, allConfigsAfterPolygon);

    _validateInterestRateStrategy(
      _findReserveConfigBySymbol(allConfigsAfterPolygon, 'BAL').interestRateStrategy,
      AaveV2PolRatesUpdates_20230328_Payload(proposalPayloadPolygon).INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV2Polygon.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        baseVariableBorrowRate: 5 * (RAY / 100),
        stableRateSlope1: 22 * (RAY / 100),
        stableRateSlope2: 150 * (RAY / 100),
        variableRateSlope1: 22 * (RAY / 100),
        variableRateSlope2: 150 * (RAY / 100)
      })
    );

    diffReports(
      'pre-AaveV2Polygon-interestRateUpdate-20230828',
      'post-AaveV2Polygon-interestRateUpdate-20230828'
    );
  }

  // Interest Strategy Ethereum

  function testUtilizationAtZeroPercentEthereum() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      BAL,
      100 * 1e18,
      0,
      0,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 0);
    assertEq(stableRate, 3 * (RAY / 100));
    assertEq(varRate, 5 * (RAY / 100));
  }

  function testUtilizationAtOneHundredPercentEthereum() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      BAL,
      0,
      0,
      100 * 1e18,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 1416000000000000000000000000);
    assertEq(stableRate, 175 * (RAY / 100));
    assertEq(varRate, 177 * (RAY / 100));
  }

  function testUtilizationAtUOptimalEthereum() public {
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategy.calculateInterestRates(
      BAL,
      20 * 1e18,
      0,
      80 * 1e18,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 172800000000000000000000000);
    assertEq(stableRate, 25 * (RAY / 100));
    assertEq(varRate, 27 * (RAY / 100));
  }

  // Interest Strategy Polygon V2

  function testUtilizationAtZeroPercentPolygonV2() public {
    vm.selectFork(polygonFork);
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategyPolygon.calculateInterestRates(
      BAL_POLYGON,
      100 * 1e18,
      0,
      0,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 0);
    assertEq(stableRate, 0 * (RAY / 100));
    assertEq(varRate, 5 * (RAY / 100));
  }

  function testUtilizationAtOneHundredPercentPolygonV2() public {
    vm.selectFork(polygonFork);
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategyPolygon.calculateInterestRates(
      BAL_POLYGON,
      0,
      0,
      100 * 1e18,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 1416000000000000000000000000);
    assertEq(stableRate, 172 * (RAY / 100));
    assertEq(varRate, 177 * (RAY / 100));
  }

  function testUtilizationAtUOptimalPolygonV2() public {
    vm.selectFork(polygonFork);
    (uint256 liqRate, uint256 stableRate, uint256 varRate) = strategyPolygon.calculateInterestRates(
      BAL_POLYGON,
      20 * 1e18,
      0,
      80 * 1e18,
      68200000000000000000000000,
      2000
    );

    assertEq(liqRate, 172800000000000000000000000);
    assertEq(stableRate, 22 * (RAY / 100));
    assertEq(varRate, 27 * (RAY / 100));
  }
}
