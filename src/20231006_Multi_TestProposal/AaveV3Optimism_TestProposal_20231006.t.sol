// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_TestProposal_20231006} from './AaveV3Optimism_TestProposal_20231006.sol';

/**
 * @dev Test for AaveV3Optimism_TestProposal_20231006
 * command: make test-contract filter=AaveV3Optimism_TestProposal_20231006
 */
contract AaveV3Optimism_TestProposal_20231006_Test is ProtocolV3TestBase {
  AaveV3Optimism_TestProposal_20231006 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 110498161);
    proposal = new AaveV3Optimism_TestProposal_20231006();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3Optimism_TestProposal_20231006',
      AaveV3Optimism.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3Optimism_TestProposal_20231006',
      AaveV3Optimism.POOL
    );

    diffReports(
      'preAaveV3Optimism_TestProposal_20231006',
      'postAaveV3Optimism_TestProposal_20231006'
    );
  }
}
