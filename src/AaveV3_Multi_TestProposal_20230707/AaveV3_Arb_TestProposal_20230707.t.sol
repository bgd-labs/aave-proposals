// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Arb_TestProposal_20230707} from './AaveV3_Arb_TestProposal_20230707.sol';

/**
 * @dev Test for AaveV3_Arb_TestProposal_20230707
 * command: make test-contract filter=AaveV3_Arb_TestProposal_20230707
 */
contract AaveV3_Arb_TestProposal_20230707_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 108800844);
  }

  function testProposalExecution() public {
    AaveV3_Arb_TestProposal_20230707 proposal = new AaveV3_Arb_TestProposal_20230707();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Arb_TestProposal_20230707',
      AaveV3Arbitrum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3_Arb_TestProposal_20230707',
      AaveV3Arbitrum.POOL
    );
  }
}