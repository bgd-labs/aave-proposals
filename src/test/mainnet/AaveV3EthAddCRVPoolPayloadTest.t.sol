// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import 'forge-std/Test.sol';
import {aveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthAddCRVPoolPayloadTest} from '../../contracts/mainnet/AaveV3EthAddCRVPoolPayload.sol';

contract AaveV3EthAddCRVPoolPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3EthAddCRVPoolPayloadTest public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16722761);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3EthAddCRVPoolPayloadTest();
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-CRV-Aave-V3-Ethereum', AaveV3Ethereum.POOL);

    ReserveConfig[] memory allConfigsEthereumBefore = _getReservesConfigs(AaveV3Ethereum.POOL);
    ReserveConfig memory crv = _findReserveConfig(
      allConfigsEthereumBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Ethereum.POOL);

    _validateReserveConfig(crv, allConfigs);

    ReserveConfig memory expectedConfig = ReserveConfig({
      symbol: 'CRV',
      underlying: AaveV2EthereumAssets.CRV_UNDERLYING,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 55_00,
      liquidationThreshold: 61_00,
      liquidationBonus: 10830,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'CRV').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: true,
      isFlashloanable: false,
      supplyCap: 62_500_000,
      borrowCap: 7_700_000,
      debtCeiling: 20_900_000,
      eModeCategory: 0
    });

    _validateReserveConfig(expectedConfig, allConfigs);

    _validateInterestRateStrategy(
      expectedConfig.interestRateStrategy,
      payload.INTEREST_RATE_STRATEGY(),
      InterestStrategyValues({
        addressesProvider: address(AaveV3Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: 70 * (RAY / 100),
        optimalStableToTotalDebtRatio: 20 * (RAY / 100),
        baseStableBorrowRate: 8 * (RAY / 100),
        stableRateSlope1: 8 * (RAY / 100),
        stableRateSlope2: 300 * (RAY / 100),
        baseVariableBorrowRate: 3 * (RAY / 100),
        variableRateSlope1: 14 * (RAY / 100),
        variableRateSlope2: 300 * (RAY / 100)
      })
    );

    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.CRV_UNDERLYING,
      AaveV2EthereumAssets.CRV_ORACLE
    );

    _validatePoolActionsPostListing(allConfigs);

    createConfigurationSnapshot('post-CRV-Aave-V3-Ethereum', AaveV3Ethereum.POOL);

    diffReports('pre-CRV-Aave-V3-Ethereum', 'post-CRV-Aave-V3-Ethereum');
  }
}
