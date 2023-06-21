// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbNativeUSDCListing_20230621} from 'src/AaveV3ArbNativeUSDCListing_20230621/AaveV3ArbNativeUSDCListing_20230621.sol';

contract AaveV3ArbNativeUSDCListing_20230621_PayloadTest is
  ProtocolV3_0_1TestBase,
  TestWithExecutor
{
  uint256 internal constant RAY = 1e27;
  AaveV3ArbNativeUSDCListing_20230621 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 103387500);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = new AaveV3ArbNativeUSDCListing_20230621();
  }

  function testReserveActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Arbitrum-Listings-20230621', AaveV3Arbitrum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Arbitrum-Listings-20230621',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory usdcn = ReserveConfig({
      symbol: 'USDC',
      underlying: payload.USDCN(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 6,
      ltv: 81_00,
      liquidationThreshold: 86_00,
      liquidationBonus: 10500,
      liquidationProtocolFee: 10_00,
      reserveFactor: 10_00,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfig(allConfigs, payload.USDCN()).interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: true,
      isFlashloanable: true,
      supplyCap: 41_000_000,
      borrowCap: 41_000_000,
      debtCeiling: 0,
      eModeCategory: 1
    });

    _validateReserveConfig(usdcn, allConfigs);

    _validateInterestRateStrategy(
      usdcn.interestRateStrategy,
      usdcn.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 90 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 45 * (RAY / 1000), // slope1 + stableRateOffset
        stableRateSlope1: 50 * (RAY / 1000),
        stableRateSlope2: 60 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 35 * (RAY / 1000),
        variableRateSlope2: 60 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      payload.USDCN(),
      payload.USDCN_PRICE_FEED()
    );

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigs, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.USDCN())
    );

    diffReports(
      'pre-Aave-V3-Arbitrum-Listings-20230621',
      'post-Aave-V3-Arbitrum-Listings-20230621'
    );
  }
}
