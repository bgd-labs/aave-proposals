// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015} from './AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015.sol';

/**
 * @dev Test for AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015
 * command: make test-contract filter=AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015
 */
contract AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18357212);
    proposal = new AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015',
      AaveV3Ethereum.POOL
    );

    e2eTest(AaveV3Ethereum.POOL);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    diffReports(
      'preAaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015',
      'postAaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015'
    );
  }
}
