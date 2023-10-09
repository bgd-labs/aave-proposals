// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';

/**
 * @dev Test for AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make test-contract filter=AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809
 */
contract AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17879754);
    proposal = new AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Ethereum.POOL
    );

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    assertTrue(AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    createConfigurationSnapshot(
      'postAaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      'postAaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809'
    );
  }
}
