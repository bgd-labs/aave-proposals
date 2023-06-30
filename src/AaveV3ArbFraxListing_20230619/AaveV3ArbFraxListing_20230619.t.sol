// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbFraxListing_20230619} from './AaveV3ArbFraxListing_20230619.sol';

contract AaveV3ArbFraxListing_20230619Test is ProtocolV3TestBase {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbFraxListing_20230619 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 104611792);
    payload = AaveV3ArbFraxListing_20230619(0x449E1B11BF74D57972D2d2CF057b337b203490C4);
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Arbitrum-FRAX-Listing', AaveV3Arbitrum.POOL);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-FRAX-Listing',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory frax = ReserveConfig({
      symbol: 'FRAX',
      underlying: payload.FRAX_UNDERLYING(),
      aToken: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
      variableDebtToken: AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
      stableDebtToken: AaveV3Arbitrum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2,
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
      supplyCap: 7_000_000,
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

    diffReports('pre-Aave-V3-Arbitrum-FRAX-Listing', 'post-Aave-V3-Arbitrum-FRAX-Listing');
  }
}
