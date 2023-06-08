// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPNewListings_20230327} from './AaveV3OPNewListings_20230327.sol';

contract AaveV3OPNewListings_20230327Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 internal constant RAY = 1e27;
  AaveV3OPNewListings_20230327 public payload;
  address public constant LUSD_USD_FEED = 0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052;
  address constant LUSD = 0xc40F949F8a4e094D1b49a23ea9241D289B7b2819;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 84098323);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    payload = new AaveV3OPNewListings_20230327();
  }

  function testLUSD() public {
    createConfigurationSnapshot('pre-Aave-V3-OP-LUSD-Listing', AaveV3Optimism.POOL);

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Optimism.POOL);

    // LUSD

    ReserveConfig memory lusd = ReserveConfig({
      symbol: 'LUSD',
      underlying: LUSD,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 0,
      liquidationThreshold: 0,
      liquidationBonus: 0,
      liquidationProtocolFee: 0,
      reserveFactor: 10_00,
      usageAsCollateralEnabled: false,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigs, 'LUSD').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: false,
      supplyCap: 3_000_000,
      borrowCap: 1_210_000,
      debtCeiling: 0,
      eModeCategory: 0
    });

    _validateReserveConfig(lusd, allConfigs);

    createConfigurationSnapshot('post-Aave-V3-OP-LUSD-Listing', AaveV3Optimism.POOL);

    diffReports('pre-Aave-V3-OP-LUSD-Listing', 'post-Aave-V3-OP-LUSD-Listing');
  }
}
