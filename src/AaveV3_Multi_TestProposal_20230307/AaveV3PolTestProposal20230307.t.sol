// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolTestProposal20230307} from './AaveV3PolTestProposal20230307.sol';

contract AaveV3PolTestProposal20230307_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), replaceWithCurrentBlockNumber);
  }

  function testProposalExecution() public {
    AaveV3PolTestProposal20230307 proposal = new AaveV3PolTestProposal20230307();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolTestProposal20230307',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      replaceWithCorrectExecutor
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'preAaveV3PolTestProposal20230307',
      AaveV3Polygon.POOL
    );
  }
}
