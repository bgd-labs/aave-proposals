// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_AaveV3ListRPL_20230711_20231107} from './AaveV3_Eth_AaveV3ListRPL_20230711_20231107.sol';

/**
 * @dev Test for AaveV3_Eth_AaveV3ListRPL_20230711_20231107
 * command: make test-contract filter=AaveV3_Eth_AaveV3ListRPL_20230711_20231107
 */
contract AaveV3_Eth_AaveV3ListRPL_20230711_20231107_Test is ProtocolV3TestBase {
  address public constant RPL_USD_FEED = 0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d;
  address public constant RPL = 0xD33526068D116cE69F19A9ee46F0bd304F21A51f;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17669147);
  }

  function testProposalExecution() public {
    AaveV3_Eth_AaveV3ListRPL_20230711_20231107 proposal = new AaveV3_Eth_AaveV3ListRPL_20230711_20231107();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Eth_AaveV3ListRPL_20230711_20231107',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'PostAaveV3_Eth_AaveV3ListRPL_20230711_20231107',
      AaveV3Ethereum.POOL
    );

    // RPL

    ReserveConfig memory RPL = ReserveConfig({
      symbol: 'RPL',
      underlying: RPL,
      aToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      variableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      stableDebtToken: address(0), // Mock, as they don't get validated, because of the "dynamic" deployment on proposal execution
      decimals: 18,
      ltv: 0,
      liquidationThreshold: 0,
      liquidationBonus: 0,
      liquidationProtocolFee: 0,
      reserveFactor: 20_00,
      usageAsCollateralEnabled: false,
      borrowingEnabled: true,
      interestRateStrategy: _findReserveConfigBySymbol(allConfigsAfter, 'RPL').interestRateStrategy,
      stableBorrowRateEnabled: false,
      isPaused: false,
      isActive: true,
      isFrozen: false,
      isSiloed: false,
      isBorrowableInIsolation: false,
      isFlashloanable: true,
      supplyCap: 105_000,
      borrowCap: 105_000,
      debtCeiling: 0,
      eModeCategory: 0
    });

    _validateReserveConfig(RPL, allConfigsAfter);

    diffReports(
      'preAaveV3_Eth_AaveV3ListRPL_20230711_20231107',
      'PostAaveV3_Eth_AaveV3ListRPL_20230711_20231107'
    );
  }
}
