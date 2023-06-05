// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ethFUSDCListing_20230605} from 'src/AaveV3ethFUSDCListing_20230605/AaveV3ethFUSDCListing_20230605.sol';

contract AaveV3ethFUSDCListing_20230605Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ethFUSDCListing_20230605 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17414747);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3ethFUSDCListing_20230605();
  }

  function testFUSDC() public {
    createConfigurationSnapshot('pre-Aave-V3-FUSDC-Listing', AaveV3Ethereum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Ethereum.POOL);

    // FUSDC

    ReserveConfig memory FUSDC = ReserveConfig({
      symbol: 'FUSDC',
      underlying: payload.FUSDC(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 75_00,
      liquidationThreshold: 80_00,
      liquidationBonus: 10450,
      liquidationProtocolFee: 2000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: false,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'FUSDC').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 220_000_000,
      borrowCap: 0,
      debtCeiling: 1_000_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(FUSDC, allConfigs);

    createConfigurationSnapshot('post-Aave-V3-FUSDC-Listing', AaveV3Ethereum.POOL);

    diffReports('pre-Aave-V3-FUSDC-Listing', 'post-Aave-V3-FUSDC-Listing');
  }
}
