// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ARBMAIListing_20230425} from './AaveV3ARBMAIListing_20230425.sol';

contract AaveV3ARBMAIListing_20230425Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3ARBMAIListing_20230425 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 84468553);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    payload = new AaveV3ARBMAIListing_20230425();
  }

  function testMAI() public {
    createConfigurationSnapshot('pre-Aave-V3-ARB-MAI-Listing', AaveV3Arbitrum.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Arbitrum.POOL);

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
      supplyCap: 4_800_000,
      borrowCap: 2_400_000,
      debtCeiling: 1_200_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(MAI, allConfigs);

    createConfigurationSnapshot('post-Aave-V3-ARB-MAI-Listing', AaveV3Arbitrum.POOL);

    diffReports('pre-Aave-V3-ARB-MAI-Listing', 'post-Aave-V3-ARB-MAI-Listing');
  }
}
