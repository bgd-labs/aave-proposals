// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_TestProposal_20230707} from './AaveV3_Pol_TestProposal_20230707.sol';

/**
 * @dev Test for AaveV3_Pol_TestProposal_20230707
 * command: make test-contract filter=AaveV3_Pol_TestProposal_20230707
 */
contract AaveV3_Pol_TestProposal_20230707_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44794122);
  }

  function testProposalExecution() public {
    AaveV3_Pol_TestProposal_20230707 proposal = new AaveV3_Pol_TestProposal_20230707();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Pol_TestProposal_20230707',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3_Pol_TestProposal_20230707',
      AaveV3Polygon.POOL
    );
  }
}