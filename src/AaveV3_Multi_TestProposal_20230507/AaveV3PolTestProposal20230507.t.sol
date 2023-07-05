// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolTestProposal20230507} from './AaveV3PolTestProposal20230507.sol';

/**
 * @dev Test for AaveV3PolTestProposal20230507
 * command: make test-contract filter=AaveV3PolTestProposal20230507
 */
contract AaveV3PolTestProposal20230507_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44708084);
  }

  function testProposalExecution() public {
    AaveV3PolTestProposal20230507 proposal = new AaveV3PolTestProposal20230507();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolTestProposal20230507',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3PolTestProposal20230507',
      AaveV3Polygon.POOL
    );
  }
}