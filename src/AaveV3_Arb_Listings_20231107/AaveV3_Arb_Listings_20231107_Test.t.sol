// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arb_Listings_20231107_Payload} from './AaveV3_Arb_Listings_20231107_Payload.sol';

/**
 * @dev Test for AaveV3_Arb_Listings_20231107_Payload
 * command: make test-contract filter=AaveV3_Arb_Listings_20231107_Test
 */
contract AaveV3_Arb_Listings_20231107_Test is ProtocolV3TestBase {
  uint256 internal constant RAY = 1e27;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 110156860);
  }

  function testProposalExecution() public {
    AaveV3_Arb_Listings_20231107_Payload payload = new AaveV3_Arb_Listings_20231107_Payload();

    createConfigurationSnapshot(
      'preAaveV3_Arb_Listings_20231107',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(payload),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'postAaveV3_Arb_Listings_20231107',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory gmx = ReserveConfig({
      symbol: 'GMX',
      underlying: payload.GMX(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 45_00,
      liquidationThreshold: 55_00,
      liquidationBonus: 10800,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfig(allConfigs, payload.GMX()).interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 110_000,
      borrowCap: 60_000,
      debtCeiling: 2_500_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(gmx, allConfigs);

    _validateInterestRateStrategy(
      gmx.interestRateStrategy,
      gmx.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 9 * (RAY / 100),
        stableRateSlope1: 13 * (RAY / 100),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      payload.GMX(),
      payload.GMX_PRICE_FEED()
    );

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigs, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.GMX())
    );

    diffReports(
      'preAaveV3_Arb_Listings_20231107',
      'postAaveV3_Arb_Listings_20231107'
    );
  }
}