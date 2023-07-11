// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Opt_TestProposal_20230707} from './AaveV3_Opt_TestProposal_20230707.sol';

/**
 * @dev Test for AaveV3_Opt_TestProposal_20230707
 * command: make test-contract filter=AaveV3_Opt_TestProposal_20230707
 */
contract AaveV3_Opt_TestProposal_20230707_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 106570452);
  }

  function testProposalExecution() public {
    AaveV3_Opt_TestProposal_20230707 proposal = new AaveV3_Opt_TestProposal_20230707();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Opt_TestProposal_20230707',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3_Opt_TestProposal_20230707',
      AaveV3Optimism.POOL
    );
  }
}