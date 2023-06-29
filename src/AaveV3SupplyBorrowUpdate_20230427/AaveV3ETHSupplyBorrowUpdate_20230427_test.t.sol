// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ETHSupplyBorrowUpdate_20230427} from './AaveV3ETHSupplyBorrowUpdate_20230427.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ETHSupplyBorrowUpdate_20230427Test is ProtocolV3LegacyTestBase {
  AaveV3ETHSupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant BORROW_CAP = 12_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16932117);
  }

  function testSupplyCapsEth() public {
    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3ETHSupplyBorrowUpdate_20230427Change',
      AaveV3Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3ETHSupplyBorrowUpdate_20230427();

    // 3. execute payload

    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 4. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3ETHSupplyBorrowUpdate_20230427Change',
      AaveV3Ethereum.POOL
    );

    //Verify payload:
    //wstETH
    ReserveConfig memory wstETHConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.wstETH_UNDERLYING
    );
    wstETHConfig.borrowCap = BORROW_CAP;
    _validateReserveConfig(wstETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3ETHSupplyBorrowUpdate_20230427Change',
      'postAaveV3ETHSupplyBorrowUpdate_20230427Change'
    );
  }
}
