// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Listings_20230403_Payload} from './AaveV3Listings_20230403_Payload.sol';

contract AaveV3Listings_20230403_PayloadTest is ProtocolV3_0_1TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3Listings_20230403_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16991341);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3Listings_20230403_Payload();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Ethereum-LDO-Listing', AaveV3Ethereum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Ethereum.POOL);

    ReserveConfig memory ldo = ReserveConfig({
      symbol: 'LDO',
      underlying: payload.LDO(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 40_00,
      liquidationThreshold: 50_00,
      liquidationBonus: 10900,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'LDO').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 6_000_000,
      borrowCap: 3_000_000,
      debtCeiling: 7_500_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(ldo, allConfigs);

    _validateInterestRateStrategy(
      ldo.interestRateStrategy,
      ldo.interestRateStrategy,
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
      payload.LDO(),
      payload.LDO_PRICE_FEED()
    );

    createConfigurationSnapshot('post-Aave-V3-Ethereum-LDO-Listing', AaveV3Ethereum.POOL);

    diffReports('pre-Aave-V3-Ethereum-LDO-Listing', 'post-Aave-V3-Ethereum-LDO-Listing');
  }
}
