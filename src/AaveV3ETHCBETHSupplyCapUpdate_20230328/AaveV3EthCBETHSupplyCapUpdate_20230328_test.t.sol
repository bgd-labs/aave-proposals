// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthCBETHSupplyCapUpdate_20230328} from './AaveV3EthCBETHSupplyCapUpdate_20230328.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3EthCBETHSupplyCapsPayload_20230328Test is ProtocolV3LegacyTestBase {
  AaveV3EthCBETHSupplyCapUpdate_20230328 public proposalPayload;

  address public constant CBETH = AaveV3EthereumAssets.cbETH_UNDERLYING;

  uint256 public constant CBETH_SUPPLY_CAP = 60_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16932117);
  }

  function testSupplyCapsEth() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3EthCBETHSupplyCapsPayload_29032023Change',
      AaveV3Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3EthCBETHSupplyCapUpdate_20230328();

    // 3. execute payload

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 4. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3EthCBETHSupplyCapsPayload_29032023Change',
      AaveV3Ethereum.POOL
    );

    //CBETH
    ReserveConfig memory CBETHConfig = _findReserveConfig(allConfigsBefore, CBETH);
    CBETHConfig.supplyCap = CBETH_SUPPLY_CAP;
    _validateReserveConfig(CBETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3EthCBETHSupplyCapsPayload_29032023Change',
      'postAaveV3EthCBETHSupplyCapsPayload_29032023Change'
    );
  }
}
