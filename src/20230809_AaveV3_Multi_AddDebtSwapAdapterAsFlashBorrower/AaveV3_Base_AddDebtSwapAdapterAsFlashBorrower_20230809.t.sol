// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809} from './AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809.sol';

/**
 * @dev Test for AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809
 * command: make test-contract filter=AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809
 */
contract AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809_Test is ProtocolV3TestBase {
  AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 4607318);
    proposal = new AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809();
  }

  function testProposalExecution() public {
    createConfigurationSnapshot(
      'preAaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Base.POOL
    );

    assertFalse(AaveV3Base.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.BASE_BRIDGE_EXECUTOR);

    assertTrue(AaveV3Base.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER()));

    createConfigurationSnapshot(
      'postAaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809',
      AaveV3Base.POOL
    );

    diffReports(
      'preAaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809',
      'postAaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809'
    );
  }
}
