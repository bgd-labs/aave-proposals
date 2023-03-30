// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ETHIsoMode_20230330} from './AaveV3ETHIsoMode_20230330.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3ETHIsoMode_20230330_Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16925078);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPayload() public {
    AaveV3ETHIsoMode_20230330 proposalPayload = new AaveV3ETHIsoMode_20230330();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3ETHIsoMode_20230330_Change', AaveV3Ethereum.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot before payload execution
    createConfigurationSnapshot('postAaveV3ETHIsoMode_20230330_Change', AaveV3Ethereum.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Ethereum.POOL);

    ReserveConfig memory USDC_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    USDC_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    ProtocolV3TestBase._validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory USDT_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    USDT_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    ProtocolV3TestBase._validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory DAI_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.DAI_UNDERLYING
    );

    DAI_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    ProtocolV3TestBase._validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory LUSD_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.LUSD_UNDERLYING
    );

    LUSD_UNDERLYING_CONFIG.isBorrowableInIsolation = true;
    ProtocolV3TestBase._validateReserveConfig(LUSD_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3ETHIsoMode_20230330_Change', 'postAaveV3ETHIsoMode_20230330_Change');
  }
}
