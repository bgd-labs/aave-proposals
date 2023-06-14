// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbListings_20230523_Payload} from './AaveV3ArbListings_20230523_Payload.sol';

contract AaveV3ArbListings_20230523_PayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbListings_20230523_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 93742385);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = new AaveV3ArbListings_20230523_Payload();
  }

  function testReserveActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Arbitrum-Listings-20230523', AaveV3Arbitrum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-Listings-20230523',
      AaveV3Arbitrum.POOL
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
      usageAsCollateralEnabled: false,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfig(allConfigs, payload.LUSD()).interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
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
        baseStableBorrowRate: 5 * (RAY / 100),
        stableRateSlope1: 4 * (RAY / 100),
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

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigs, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.LUSD())
    );

    diffReports(
      'pre-Aave-V3-Arbitrum-Listings-20230523',
      'post-Aave-V3-Arbitrum-Listings-20230523'
    );
  }
}
