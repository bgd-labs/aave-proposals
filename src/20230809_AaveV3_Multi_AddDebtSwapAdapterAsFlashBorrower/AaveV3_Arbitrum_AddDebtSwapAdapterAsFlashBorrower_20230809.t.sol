// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';

/**
 * @dev Test for AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make test-contract filter=AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809
 */
contract AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809_Test is ProtocolV3TestBase {
  AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 119814137);
    proposal = new AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Arbitrum.POOL
    );

    assertFalse(AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    assertTrue(AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    createConfigurationSnapshot(
      'postAaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Arbitrum.POOL
    );

    diffReports(
      'preAaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809',
      'postAaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809'
    );
  }
}
