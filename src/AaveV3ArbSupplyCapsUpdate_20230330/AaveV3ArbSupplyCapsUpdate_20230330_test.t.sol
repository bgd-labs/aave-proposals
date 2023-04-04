// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbSupplyCapsUpdate_20230330} from './AaveV3ArbSupplyCapsUpdate_20230330.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbSupplyCapsUpdate_20230330_Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ArbSupplyCapsUpdate_20230330 public proposalPayload;

  uint256 public constant WBTC_SUPPLY_CAP = 4_200;
  uint256 public constant WETH_SUPPLY_CAP = 70_000;
  uint256 public constant WETH_BORROW_CAP = 22_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 76220649);
    _selectPayloadExecutor(AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);
  }

  function testSupplyCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Arbitrum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3ArbSupplyCapsUpdate_20230330Change',
      AaveV3Arbitrum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3ArbSupplyCapsUpdate_20230330();

    // 3. execute payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3ArbSupplyCapsUpdate_20230330Change',
      AaveV3Arbitrum.POOL
    );

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Arbitrum.POOL
    );

    //WBTC
    ReserveConfig memory WBTCConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WBTC_UNDERLYING
    );
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(WBTCConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );
    WETHConfig.supplyCap = WETH_SUPPLY_CAP;
    WETHConfig.borrowCap = WETH_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(WETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3ArbSupplyCapsUpdate_20230330Change',
      'postAaveV3ArbSupplyCapsUpdate_20230330Change'
    );
  }
}
