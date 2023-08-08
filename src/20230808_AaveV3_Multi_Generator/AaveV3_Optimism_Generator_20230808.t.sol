// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Optimism_Generator_20230808} from './AaveV3_Optimism_Generator_20230808.sol';

/**
 * @dev Test for AaveV3_Optimism_Generator_20230808
 * command: make test-contract filter=AaveV3_Optimism_Generator_20230808
 */
contract AaveV3_Optimism_Generator_20230808_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 107950263);
  }

  function testProposalExecution() public {
    AaveV3_Optimism_Generator_20230808 proposal = new AaveV3_Optimism_Generator_20230808();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Optimism_Generator_20230808',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Optimism_Generator_20230808',
      AaveV3Optimism.POOL
    );

    diffReports('preAaveV3_Optimism_Generator_20230808', 'postAaveV3_Optimism_Generator_20230808');
  }
}