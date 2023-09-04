// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Metis_CapsUpgrade_20230904_20230904} from './AaveV3_Metis_CapsUpgrade_20230904_20230904.sol';

/**
 * @dev Test for AaveV3_Metis_CapsUpgrade_20230904_20230904
 * command: make test-contract filter=AaveV3_Metis_CapsUpgrade_20230904_20230904
 */
contract AaveV3_Metis_CapsUpgrade_20230904_20230904_Test is ProtocolV3TestBase {
  AaveV3_Metis_CapsUpgrade_20230904_20230904 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 8405352);
    proposal = new AaveV3_Metis_CapsUpgrade_20230904_20230904();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Metis_CapsUpgrade_20230904_20230904',
      AaveV3Metis.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Metis_CapsUpgrade_20230904_20230904',
      AaveV3Metis.POOL
    );

    diffReports(
      'preAaveV3_Metis_CapsUpgrade_20230904_20230904',
      'postAaveV3_Metis_CapsUpgrade_20230904_20230904'
    );
  }
}
