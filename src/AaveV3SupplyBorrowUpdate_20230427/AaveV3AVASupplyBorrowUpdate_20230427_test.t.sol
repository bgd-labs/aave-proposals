// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3AVASupplyBorrowUpdate_20230427} from './AaveV3AVASupplyBorrowUpdate_20230427.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3AVASupplyBorrowUpdate_20230427Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3AVASupplyBorrowUpdate_20230427 public proposalPayload;

  uint256 public constant WAVAX_BORROW_CAP = 2_400_000;


  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 29282429);
    _selectPayloadExecutor(AaveV3Avalanche.ACL_ADMIN);
  }

  function testSupplyCapsEth() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Avalanche.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3AVASupplyBorrowUpdate_20230427Change',
      AaveV3Avalanche.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV3AVASupplyBorrowUpdate_20230427();

    // 3. execute payload

    _executePayload(address(proposalPayload));

    // 4. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3AVASupplyBorrowUpdate_20230427Change',
      AaveV3Avalanche.POOL
    );

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Avalanche.POOL
    );

    //WAVAX
    ReserveConfig memory WAVAXConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.WAVAX_UNDERLYING
    );
    WAVAXConfig.borrowCap = WAVAX_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(WAVAXConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3AVASupplyBorrowUpdate_20230427Change',
      'postAaveV3AVASupplyBorrowUpdate_20230427Change'
    );
  }
}
