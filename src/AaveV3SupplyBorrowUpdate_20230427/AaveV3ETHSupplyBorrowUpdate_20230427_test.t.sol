// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ETHSupplyBorrowUpdate_20230427} from './AaveV3ETHSupplyBorrowUpdate_20230427.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3ETHSupplyBorrowUpdate_20230427Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3ETHSupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant BORROW_CAP = 12_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16932117);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testSupplyCapsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Ethereum.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3ETHSupplyBorrowUpdate_20230427Change',
      AaveV3Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3ETHSupplyBorrowUpdate_20230427();

    // 3. execute payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3ETHSupplyBorrowUpdate_20230427Change',
      AaveV3Ethereum.POOL
    );

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Ethereum.POOL
    );

    //wstETH
    ReserveConfig memory wstETHConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.wstETH_UNDERLYING
    );
    wstETHConfig.borrowCap = BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(wstETHConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3ETHSupplyBorrowUpdate_20230427Change',
      'postAaveV3ETHSupplyBorrowUpdate_20230427Change'
    );
  }
}
