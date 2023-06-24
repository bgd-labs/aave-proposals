// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbFraxListing_20230619} from './AaveV3ArbFraxListing_20230619.sol';

contract AaveV3ArbFraxListing_20230619Test is ProtocolV3_0_1TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbFraxListing_20230619 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 103836954);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = AaveV3ArbFraxListing_20230619(0xB57183F99e7986A751A08FeAc6E26a040C541a0b);
  }

  function testPoolActivation() public {
    createConfigurationSnapshot(
      'pre-Aave-V3-Arbitrum-FRAX-Listing',
      AaveV3Arbitrum.POOL
    );

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-FRAX-Listing',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory frax = ReserveConfig({
      symbol: 'FRAX',
      underlying: payload.FRAX_UNDERLYING(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 70_00,
      liquidationThreshold: 75_00,
      liquidationBonus: 10600,
      liquidationProtocolFee: 1000,
      reserveFactor: 1000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'FRAX').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap:7_000_000,
      borrowCap: 5_500_000,
      debtCeiling: 1_000_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(frax, allConfigs);

    _validateInterestRateStrategy(
      frax.interestRateStrategy,
      frax.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 80 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 5 * (RAY / 100),
        stableRateSlope1: 5 * (RAY / 1000),
        stableRateSlope2: 75 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4 * (RAY / 100),
        variableRateSlope2: 75 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      payload.FRAX_UNDERLYING(),
      payload.PRICE_FEED()
    );

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigs, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.FRAX_UNDERLYING())
    );

    diffReports(
      'pre-Aave-V3-Arbitrum-FRAX-Listing',
      'post-Aave-V3-Arbitrum-FRAX-Listing'
    );
  }
}
