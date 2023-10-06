// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_TestProposal_20231006} from './AaveV3Avalanche_TestProposal_20231006.sol';

/**
 * @dev Test for AaveV3Avalanche_TestProposal_20231006
 * command: make test-contract filter=AaveV3Avalanche_TestProposal_20231006
 */
contract AaveV3Avalanche_TestProposal_20231006_Test is ProtocolV3TestBase {
  AaveV3Avalanche_TestProposal_20231006 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 36106123);
    proposal = new AaveV3Avalanche_TestProposal_20231006();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3Avalanche_TestProposal_20231006',
      AaveV3Avalanche.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3Avalanche_TestProposal_20231006',
      AaveV3Avalanche.POOL
    );

    diffReports(
      'preAaveV3Avalanche_TestProposal_20231006',
      'postAaveV3Avalanche_TestProposal_20231006'
    );
  }
}
