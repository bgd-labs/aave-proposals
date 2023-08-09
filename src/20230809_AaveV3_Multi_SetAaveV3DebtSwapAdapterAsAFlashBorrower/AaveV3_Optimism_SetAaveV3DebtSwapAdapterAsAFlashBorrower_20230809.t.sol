// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809} from './AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809.sol';

/**
 * @dev Test for AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809
 * command: make test-contract filter=AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809
 */
contract AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809_Test is ProtocolV3TestBase {
  AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 108006570);
   proposal = new AaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809();
  }

  function testProposalExecution() public {


    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809',
      AaveV3Optimism.POOL
    );

    diffReports('preAaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809', 'postAaveV3_Optimism_SetAaveV3DebtSwapAdapterAsAFlashBorrower_20230809');
  }function test_isFlashBorrower() {
    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );
    AaveV3Optimism.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
  }}