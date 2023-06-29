// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthNewListings_20230321} from './AaveV3EthNewListings_20230321.sol';

contract AaveV3EthNewListings_20230321Test is ProtocolV3TestBase {
  uint256 internal constant RAY = 1e27;
  AaveV3EthNewListings_20230321 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16890867);
    payload = new AaveV3EthNewListings_20230321();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot(
      'pre-Aave-V3-Ethereum-UNI-BAL-MKR-SNX-Listings',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Ethereum-UNI-BAL-MKR-SNX-Listings',
      AaveV3Ethereum.POOL
    );

    // UNI

    ReserveConfig memory uni = ReserveConfig({
      symbol: 'UNI',
      underlying: AaveV2EthereumAssets.UNI_UNDERLYING,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 65_00,
      liquidationThreshold: 77_00,
      liquidationBonus: 11000,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'UNI').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 2_000_000,
      borrowCap: 500_000,
      debtCeiling: 17_000_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(uni, allConfigs);

    _validateInterestRateStrategy(
      uni.interestRateStrategy,
      uni.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 10 * (RAY / 100),
        stableRateSlope1: 13 * (RAY / 100),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.UNI_UNDERLYING,
      payload.UNI_PRICE_FEED()
    );

    // MKR

    ReserveConfig memory mkr = ReserveConfig({
      symbol: 'MKR',
      underlying: AaveV2EthereumAssets.MKR_UNDERLYING,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 65_00,
      liquidationThreshold: 70_00,
      liquidationBonus: 10850,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'MKR').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 6_000,
      borrowCap: 1_500,
      debtCeiling: 2_500_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(mkr, allConfigs);

    _validateInterestRateStrategy(
      mkr.interestRateStrategy,
      mkr.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 10 * (RAY / 100),
        stableRateSlope1: 13 * (RAY / 100),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.MKR_UNDERLYING,
      payload.MKR_PRICE_FEED()
    );

    // SNX

    ReserveConfig memory snx = ReserveConfig({
      symbol: 'SNX',
      underlying: AaveV2EthereumAssets.SNX_UNDERLYING,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 49_00,
      liquidationThreshold: 65_00,
      liquidationBonus: 10850,
      liquidationProtocolFee: 1000,
      reserveFactor: 3500,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'SNX').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 2_000_000,
      borrowCap: 1_100_000,
      debtCeiling: 2_500_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(snx, allConfigs);

    _validateInterestRateStrategy(
      snx.interestRateStrategy,
      snx.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 18 * (RAY / 100),
        stableRateSlope1: 15 * (RAY / 100),
        stableRateSlope2: 100 * (RAY / 100),
        baseVariableBorrowRate: 3 * (RAY / 100),
        variableRateSlope1: 15 * (RAY / 100),
        variableRateSlope2: 100 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.SNX_UNDERLYING,
      payload.SNX_PRICE_FEED()
    );

    // BAL

    ReserveConfig memory bal = ReserveConfig({
      symbol: 'BAL',
      underlying: AaveV2EthereumAssets.BAL_UNDERLYING,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 57_00,
      liquidationThreshold: 62_00,
      liquidationBonus: 10830,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'BAL').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 700_000,
      borrowCap: 185_000,
      debtCeiling: 2_900_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(bal, allConfigs);

    _validateInterestRateStrategy(
      bal.interestRateStrategy,
      bal.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 17 * (RAY / 100),
        stableRateSlope1: 20 * (RAY / 100),
        stableRateSlope2: 150 * (RAY / 100),
        baseVariableBorrowRate: 3 * (RAY / 100),
        variableRateSlope1: 14 * (RAY / 100),
        variableRateSlope2: 150 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.BAL_UNDERLYING,
      payload.BAL_PRICE_FEED()
    );

    diffReports(
      'pre-Aave-V3-Ethereum-UNI-BAL-MKR-SNX-Listings',
      'post-Aave-V3-Ethereum-UNI-BAL-MKR-SNX-Listings'
    );
  }
}
