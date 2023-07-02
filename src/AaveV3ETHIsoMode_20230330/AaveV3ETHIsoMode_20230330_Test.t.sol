// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ETHIsoMode_20230330} from './AaveV3ETHIsoMode_20230330.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3ETHIsoMode_20230330_Test is ProtocolV3LegacyTestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16925078);
  }

  function testPayload() public {
    AaveV3ETHIsoMode_20230330 proposalPayload = new AaveV3ETHIsoMode_20230330();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3ETHIsoMode_20230330_Change',
      AaveV3Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot before payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3ETHIsoMode_20230330_Change',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    USDC_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory USDT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    USDT_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    _validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory DAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.DAI_UNDERLYING
    );

    DAI_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    _validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory LUSD_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.LUSD_UNDERLYING
    );

    LUSD_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    _validateReserveConfig(LUSD_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3ETHIsoMode_20230330_Change', 'postAaveV3ETHIsoMode_20230330_Change');
  }
}
