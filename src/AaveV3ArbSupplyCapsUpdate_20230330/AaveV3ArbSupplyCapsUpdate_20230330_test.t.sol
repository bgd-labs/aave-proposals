// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbSupplyCapsUpdate_20230330} from './AaveV3ArbSupplyCapsUpdate_20230330.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ArbSupplyCapsUpdate_20230330_Test is ProtocolV3LegacyTestBase {
  AaveV3ArbSupplyCapsUpdate_20230330 public proposalPayload;

  uint256 public constant WBTC_SUPPLY_CAP = 4_200;
  uint256 public constant WETH_SUPPLY_CAP = 70_000;
  uint256 public constant WETH_BORROW_CAP = 22_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 76220649);
  }

  function testSupplyCapsArb() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3ArbSupplyCapsUpdate_20230330Change',
      AaveV3Arbitrum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3ArbSupplyCapsUpdate_20230330();

    // 3. execute payload

    GovHelpers.executePayload(
      vm,
      address(proposalPayload),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    // 4. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3ArbSupplyCapsUpdate_20230330Change',
      AaveV3Arbitrum.POOL
    );

    //WBTC
    ReserveConfig memory WBTCConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WBTC_UNDERLYING
    );
    WBTCConfig.supplyCap = WBTC_SUPPLY_CAP;
    _validateReserveConfig(WBTCConfig, allConfigsAfter);

    //WETH
    ReserveConfig memory WETHConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );
    WETHConfig.supplyCap = WETH_SUPPLY_CAP;
    WETHConfig.borrowCap = WETH_BORROW_CAP;
    _validateReserveConfig(WETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3ArbSupplyCapsUpdate_20230330Change',
      'postAaveV3ArbSupplyCapsUpdate_20230330Change'
    );
  }
}
