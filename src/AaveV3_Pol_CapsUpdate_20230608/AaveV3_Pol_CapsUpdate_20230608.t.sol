// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_CapsUpdate_20230608} from './AaveV3_Pol_CapsUpdate_20230608.sol';

/**
 * @dev Test for AaveV3_Pol_CapsUpdate_20230608
 * command: make test-contract filter=AaveV3_Pol_CapsUpdate_20230608
 */
contract AaveV3_Pol_CapsUpdate_20230608_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 45990780);
  }

  function testProposalExecution() public {
    AaveV3_Pol_CapsUpdate_20230608 proposal = new AaveV3_Pol_CapsUpdate_20230608();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Pol_CapsUpdate_20230608',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Pol_CapsUpdate_20230608',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory MaticX = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    MaticX.supplyCap = proposal.NEW_SUPPLY_CAP();

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.MaticX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(MaticX, allConfigsAfter);

    e2eTestAsset(
        AaveV3Polygon.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.stMATIC_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.MaticX_UNDERLYING)
        );

    diffReports('preAaveV3_Pol_CapsUpdate_20230608', 'postAaveV3_Pol_CapsUpdate_20230608');
  }
}
