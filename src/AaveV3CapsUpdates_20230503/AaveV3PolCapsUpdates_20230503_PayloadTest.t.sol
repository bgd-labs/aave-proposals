// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230503_Payload} from './AaveV3PolCapsUpdates_20230503_Payload.sol';

contract AaveV3PolCapsUpdates_20230503_PayloadTest is ProtocolV3LegacyTestBase {
  AaveV3PolCapsUpdates_20230503_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42257394);
    payload = new AaveV3PolCapsUpdates_20230503_Payload();
  }

  function testPoolActivation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230503',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig memory MaticX = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    MaticX.supplyCap = payload.NEW_SUPPLY_CAP();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230503',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.MaticX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(MaticX, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230503',
      'post-Aave-V3-Polygon-Caps-Updates-20230503'
    );
  }
}
