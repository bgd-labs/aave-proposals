// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Optimism_TestGovV3_20230920} from './AaveV3_Optimism_TestGovV3_20230920.sol';

/**
 * @dev Test for AaveV3_Optimism_TestGovV3_20230920
 * command: make test-contract filter=AaveV3_Optimism_TestGovV3_20230920
 */
contract AaveV3_Optimism_TestGovV3_20230920_Test is ProtocolV3TestBase {
  AaveV3_Optimism_TestGovV3_20230920 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 109800684);
    proposal = new AaveV3_Optimism_TestGovV3_20230920();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Optimism_TestGovV3_20230920',
      AaveV3Optimism.POOL
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Optimism_TestGovV3_20230920',
      AaveV3Optimism.POOL
    );

    diffReports('preAaveV3_Optimism_TestGovV3_20230920', 'postAaveV3_Optimism_TestGovV3_20230920');
  }
}
