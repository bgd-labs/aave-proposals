// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPMAIListing_20230425} from './AaveV3OPMAIListing_20230425.sol';

contract AaveV3OPMAIListing_20230425Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3OPMAIListing_20230425 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 94384832);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    payload = new AaveV3OPMAIListing_20230425();
  }

  function testMAI() public {
    createConfigurationSnapshot('pre-Aave-V3-OP-MAI-Listing', AaveV3Optimism.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Optimism.POOL);

    // MAI

    ReserveConfig memory MAI = ReserveConfig({
      symbol: 'MAI',
      underlying: payload.MAI(),
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 75_00,
      liquidationThreshold: 80_00,
      liquidationBonus: 10500,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'MAI').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 7_600_000,
      borrowCap: 2_500_000,
      debtCeiling: 1_900_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(MAI, allConfigs);

    createConfigurationSnapshot('post-Aave-V3-OP-MAI-Listing', AaveV3Optimism.POOL);

    diffReports('pre-Aave-V3-OP-MAI-Listing', 'post-Aave-V3-OP-MAI-Listing');
  }
}
