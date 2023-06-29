// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbListings_20230524_Payload} from './AaveV3ArbListings_20230524_Payload.sol';

contract AaveV3ArbListings_20230524_PayloadTest is ProtocolV3TestBase {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbListings_20230524_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 99531326);
    payload = new AaveV3ArbListings_20230524_Payload();
  }

  function testReserveActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Arbitrum-Listings-20230524', AaveV3Arbitrum.POOL);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-Listings-20230524',
      AaveV3Arbitrum.POOL
    );

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
      interestRateStrategy: _findReserveConfig(allConfigs, payload.RETH()).interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
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
        baseStableBorrowRate: 10 * (RAY / 100),
        stableRateSlope1: 13 * (RAY / 100),
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

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigs, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.RETH())
    );

    diffReports(
      'pre-Aave-V3-Arbitrum-Listings-20230524',
      'post-Aave-V3-Arbitrum-Listings-20230524'
    );
  }
}
