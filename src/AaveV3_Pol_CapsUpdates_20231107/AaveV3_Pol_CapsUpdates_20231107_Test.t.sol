// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_CapsUpdates_20231107_Payload} from './AaveV3_Pol_CapsUpdates_20231107_Payload.sol';

/**
 * @dev Test for AaveV3_Pol_CapsUpdates_20231107
 * command: make test-contract filter=AaveV3_Pol_CapsUpdates_20231107_Test
 */
contract AaveV3_Pol_CapsUpdates_20231107_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44960950);
  }

  function testProposalExecution() public {
    AaveV3_Pol_CapsUpdates_20231107_Payload proposal = new AaveV3_Pol_CapsUpdates_20231107_Payload();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Pol_CapsUpdates_20231107',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig memory MaticX = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    MaticX.supplyCap = proposal.NEW_SUPPLY_CAP_MATICX();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Pol_CapsUpdates_20231107',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.MaticX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(MaticX, allConfigsAfter);

    diffReports('preAaveV3_Pol_CapsUpdates_20231107', 'postAaveV3_Pol_CapsUpdates_20231107');
  }
}
