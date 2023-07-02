// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Listings_20230413_Payload} from './AaveV3Listings_20230413_Payload.sol';

contract AaveV3Listings_20230413_PayloadTest is ProtocolV3TestBase {
  uint256 internal constant RAY = 1e27;
  AaveV3Listings_20230413_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 41497996);
    payload = new AaveV3Listings_20230413_Payload();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Polygon-wstETH-Listing', AaveV3Polygon.POOL);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-wstETH-Listing',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory wsteth = ReserveConfig({
      symbol: 'wstETH',
      underlying: payload.wstETH(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 70_00,
      liquidationThreshold: 79_00,
      liquidationBonus: 10720,
      liquidationProtocolFee: 1000,
      reserveFactor: 1500,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'wstETH').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 1_800,
      borrowCap: 285,
      debtCeiling: 0,
      eModeCategory: payload.EMODE_CATEGORY_ID_ETH_CORRELATED()
    });

    _validateReserveConfig(wsteth, allConfigs);

    _validateInterestRateStrategy(
      wsteth.interestRateStrategy,
      wsteth.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Polygon.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 55 * (RAY / 1000),
        stableRateSlope1: 45 * (RAY / 1000),
        stableRateSlope2: 80 * (RAY / 100),
        baseVariableBorrowRate: 25 * (RAY / 10000),
        variableRateSlope1: 45 * (RAY / 1000),
        variableRateSlope2: 80 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      payload.wstETH(),
      payload.wstETH_PRICE_FEED()
    );

    diffReports('pre-Aave-V3-Polygon-wstETH-Listing', 'post-Aave-V3-Polygon-wstETH-Listing');
  }
}
