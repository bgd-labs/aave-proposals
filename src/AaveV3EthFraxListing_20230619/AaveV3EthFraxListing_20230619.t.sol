// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3_0_1TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthFraxListing_20230619} from './AaveV3EthFraxListing_20230619.sol';

contract AaveV3EthFraxListing_20230619Test is ProtocolV3_0_1TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3EthFraxListing_20230619 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17536695);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = AaveV3EthFraxListing_20230619(0x56Cf1dbd6CfCA7898BA6A96Ce1Fbf1F038E6466b);
  }

  function testPoolActivation() public {
    createConfigurationSnapshot(
      'pre-Aave-V3-Ethereum-FRAX-Listing',
      AaveV3Ethereum.POOL
    );

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-Aave-V3-Ethereum-FRAX-Listing',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory frax = ReserveConfig({
      symbol: 'FRAX',
      underlying: AaveV2EthereumAssets.FRAX_UNDERLYING,
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
      supplyCap: 15_000_000,
      borrowCap: 12_000_000,
      debtCeiling: 10_000_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(frax, allConfigs);

    _validateInterestRateStrategy(
      frax.interestRateStrategy,
      frax.interestRateStrategy,
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
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
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      payload.PRICE_FEED()
    );

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigs, AaveV2EthereumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigs, AaveV2EthereumAssets.FRAX_UNDERLYING)
    );

    diffReports(
      'pre-Aave-V3-Ethereum-FRAX-Listing',
      'post-Aave-V3-Ethereum-FRAX-Listing'
    );
  }
}
