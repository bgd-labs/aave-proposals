// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ArbWSTETHListingPayload} from '../../contracts/arbitrum/AaveV3ArbWSTETHListingPayload.sol';

contract AaveV3ArbWSTETHListingPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ArbWSTETHListingPayload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 62456736);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = new AaveV3ArbWSTETHListingPayload();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-wstETH-Aave-V3-Arbitrum', AaveV3Arbitrum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Arbitrum.POOL);
    ReserveConfig memory expectedConfig = ReserveConfig({
      symbol: 'wstETH',
      underlying: payload.WSTETH(),
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
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 1200,
      borrowCap: 190,
      debtCeiling: 0,
      eModeCategory: 1
    });

    _validateReserveConfig(expectedConfig, allConfigs);

    _validateInterestRateStrategy(
      expectedConfig.interestRateStrategy,
      payload.INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 55 * (RAY / 1000),
        stableRateSlope1: 0,
        stableRateSlope2: 0,
        baseVariableBorrowRate: 25 * (RAY / 10000),
        variableRateSlope1: 45 * (RAY / 1000),
        variableRateSlope2: 80 * (RAY / 100)
      })
    );

    createConfigurationSnapshot('post-wstETH-Aave-V3-Arbitrum', AaveV3Arbitrum.POOL);

    diffReports('pre-wstETH-Aave-V3-Arbitrum', 'post-wstETH-Aave-V3-Arbitrum');
  }
}
