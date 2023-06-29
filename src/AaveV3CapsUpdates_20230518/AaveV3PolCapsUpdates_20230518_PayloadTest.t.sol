// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230518_Payload} from './AaveV3PolCapsUpdates_20230518_Payload.sol';

contract AaveV3PolCapsUpdates_20230518_PayloadTest is ProtocolV3LegacyTestBase {
  AaveV3PolCapsUpdates_20230518_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 42863668);
    payload = new AaveV3PolCapsUpdates_20230518_Payload();
  }

  function testCapsUpdates() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230518',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig memory wMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WMATIC_UNDERLYING
    );

    wMATIC.supplyCap = payload.NEW_SUPPLY_CAP();
    wMATIC.borrowCap = payload.NEW_BORROW_CAP();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230518',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.WMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(wMATIC, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230518',
      'post-Aave-V3-Polygon-Caps-Updates-20230518'
    );
  }
}
