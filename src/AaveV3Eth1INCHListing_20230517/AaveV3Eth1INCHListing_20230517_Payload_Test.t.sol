// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Eth1INCHListing_20230517_Payload} from './AaveV3Eth1INCHListing_20230517_Payload.sol';

contract AaveV3Eth1INCHListing_20230517_Payload_Test is ProtocolV3_0_1TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3Eth1INCHListing_20230517_Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17269492);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3Eth1INCHListing_20230517_Payload();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-Aave-V3-Ethereum-1INCH-Listing', AaveV3Ethereum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Ethereum-1INCH-Listing',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory oneInch = ReserveConfig({
      symbol: '1INCH',
      underlying: payload.ONEINCH(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 57_00,
      liquidationThreshold: 67_00,
      liquidationBonus: 10750,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, '1INCH').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 22_000_000,
      borrowCap: 720_000,
      debtCeiling: 4_500_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(oneInch, allConfigs);

    _validateInterestRateStrategy(
      oneInch.interestRateStrategy,
      oneInch.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 45 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 12 * (RAY / 100),
        stableRateSlope1: 13 * (RAY / 100),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      payload.ONEINCH(),
      payload.ONEINCH_PRICE_FEED()
    );

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigs, AaveV3EthereumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, payload.ONEINCH())
    );

    diffReports('pre-Aave-V3-Ethereum-1INCH-Listing', 'post-Aave-V3-Ethereum-1INCH-Listing');
  }
}
