// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arb_ARBListing_20231207} from './AaveV3_Arb_ARBListing_20231207.sol';

/**
 * @dev Test for AaveV3_Arb_ARBListing_20231207
 * command: make test-contract filter=AaveV3_Arb_ARBListing_20231207
 */
contract AaveV3_Arb_ARBListing_20231207_Test is ProtocolV3TestBase {
  address public constant ARB_USD_FEED = 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6;
  address public constant ARB = 0x912CE59144191C1204E64559FE8253a0e49E6548;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 110366299);
  }

  function testProposalExecution() public {
    AaveV3_Arb_ARBListing_20231207 proposal = new AaveV3_Arb_ARBListing_20231207();

    createConfigurationSnapshot(
      'preAaveV3_Arb_ARBListing_20231207',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Arb_ARBListing_20231207',
      AaveV3Arbitrum.POOL
    );

    // ARB

    ReserveConfig memory ARB_ASSET = ReserveConfig({
      symbol: 'ARB',
      underlying: ARB,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 50_00,
      liquidationThreshold: 60_00,
      liquidationBonus: 11000,
      liquidationProtocolFee: 1000,
      reserveFactor: 2000,
      usageAsCollateralEnabled: true,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigsAfter, 'ARB').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 20_000_000,
      borrowCap: 16_500_000,
      debtCeiling: 14_000_000_00,
      eModeCategory: 0
    });

    _validateReserveConfig(ARB_ASSET, allConfigsAfter);

    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.USDC_UNDERLYING),
      _findReserveConfig(allConfigsAfter, ARB)
    );

    diffReports('preAaveV3_Arb_ARBListing_20231207', 'postAaveV3_Arb_ARBListing_20231207');
  }
}
