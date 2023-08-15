// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Polygon_StataTokenOperationalUpdate_20230815} from './AaveV3_Polygon_StataTokenOperationalUpdate_20230815.sol';

/**
 * @dev Test for AaveV3_Polygon_StataTokenOperationalUpdate_20230815
 * command: make test-contract filter=AaveV3_Polygon_StataTokenOperationalUpdate_20230815
 */
contract AaveV3_Polygon_StataTokenOperationalUpdate_20230815_Test is ProtocolV3TestBase {
  AaveV3_Polygon_StataTokenOperationalUpdate_20230815 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46328023);
   proposal = new AaveV3_Polygon_StataTokenOperationalUpdate_20230815();
  }

  function testProposalExecution() public {


    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Polygon_StataTokenOperationalUpdate_20230815',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Polygon_StataTokenOperationalUpdate_20230815',
      AaveV3Polygon.POOL
    );

    diffReports('preAaveV3_Polygon_StataTokenOperationalUpdate_20230815', 'postAaveV3_Polygon_StataTokenOperationalUpdate_20230815');
  }}