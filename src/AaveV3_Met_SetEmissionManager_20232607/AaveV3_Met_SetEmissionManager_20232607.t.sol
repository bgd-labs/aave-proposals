// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Met_SetEmissionManager_20232607} from './AaveV3_Met_SetEmissionManager_20232607.sol';

/**
 * @dev Test for AaveV3_Met_SetEmissionManager_20232607
 * command: make test-contract filter=AaveV3_Met_SetEmissionManager_20232607
 */
contract AaveV3_Met_SetEmissionManager_20232607_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 7487447);
  }

  function testProposalExecution() public {
    AaveV3_Met_SetEmissionManager_20232607 proposal = new AaveV3_Met_SetEmissionManager_20232607();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Met_SetEmissionManager_20232607',
      AaveV3Metis.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.METIS_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Met_SetEmissionManager_20232607',
      AaveV3Metis.POOL
    );

    e2eTest(
      AaveV3Metis.POOL
    );

    diffReports(
      'preAaveV3_Met_SetEmissionManager_20232607',
      'postAaveV3_Met_SetEmissionManager_20232607'
    );
  }
}
