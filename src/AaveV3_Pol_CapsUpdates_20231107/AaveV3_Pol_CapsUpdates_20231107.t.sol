// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_CapsUpdates_20231107} from './AaveV3_Pol_CapsUpdates_20231107.sol';

/**
 * @dev Test for AaveV3_Pol_CapsUpdates_20231107
 * command: make test-contract filter=AaveV3_Pol_CapsUpdates_20231107
 */
contract AaveV3_Pol_CapsUpdates_20231107_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44960950);
  }

  function testProposalExecution() public {
    AaveV3_Pol_CapsUpdates_20231107 proposal = new AaveV3_Pol_CapsUpdates_20231107();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Pol_CapsUpdates_20231107',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3_Pol_CapsUpdates_20231107',
      AaveV3Polygon.POOL
    );
  }
}