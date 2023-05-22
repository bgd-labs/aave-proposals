// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbListings_20230523_Payload} from './AaveV3ArbListings_20230523_Payload.sol';

contract AaveV3ArbListings_20230523_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbListings_20230523_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 93404396);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = new AaveV3ArbListings_20230523_Payload();
  }

  function testPoolActivation() public {
    ReserveConfig[] memory allConfigs = createConfigurationSnapshot('pre-Aave-V3-Arbitrum-Listings-20230523', AaveV3Arbitrum.POOL);

    _executePayload(address(payload));

    ReserveConfig memory rETH = ReserveConfig({
      symbol: 'rETH',
      underlying: payload.RETH(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 67_00,
      liquidationThreshold: 74_00,
      liquidationBonus: 10750,
      liquidationProtocolFee: 1000,
      reserveFactor: 1500,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'rETH').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 325,
      borrowCap: 85,
      debtCeiling: 0,
      eModeCategory: 0
    });

    _validateReserveConfig(rETH, allConfigs);

    _validateInterestRateStrategy(
      rETH.interestRateStrategy,
      rETH.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 10 * (RAY / 1000),
        stableRateSlope1: 13 * (RAY / 1000),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      payload.RETH(),
      payload.RETH_PRICE_FEED()
    );

     ReserveConfig memory lusd = ReserveConfig({
      symbol: 'LUSD',
      underlying: payload.LUSD(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 0,
      liquidationThreshold: 0,
      liquidationBonus: 0,
      liquidationProtocolFee: 0,
      reserveFactor: 1000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'LUSD').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 900_000,
      borrowCap: 900_000,
      debtCeiling: 0,
      eModeCategory: 0
    });

    _validateReserveConfig(lusd, allConfigs);

    _validateInterestRateStrategy(
      lusd.interestRateStrategy,
      lusd.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 4 * (RAY / 100),
        stableRateSlope1: 4 * (RAY / 1000),
        stableRateSlope2: 87 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4 * (RAY / 100),
        variableRateSlope2: 87 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      payload.LUSD(),
      payload.LUSD_PRICE_FEED()
    );

    createConfigurationSnapshot('post-Aave-V3-Arbitrum-Listings-20230523', AaveV3Arbitrum.POOL);

    diffReports('pre-Aave-V3-Arbitrum-Listings-20230523', 'post-Aave-V3-Arbitrum-Listings-20230523');
  }
}