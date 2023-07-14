// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230328} from './AaveV3PolCapsUpdates_20230328.sol';

contract AaveV3PolCapsUpdates_20230328Test is ProtocolV3LegacyTestBase {
  AaveV3PolCapsUpdates_20230328 payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40865022);
    payload = new AaveV3PolCapsUpdates_20230328();
  }

  function testPoolActivation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230328',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig memory wMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.WMATIC_UNDERLYING
    );

    ReserveConfig memory bal = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.BAL_UNDERLYING
    );

    wMATIC.supplyCap = payload.NEW_SUPPLY_CAP();
    bal.borrowCap = payload.NEW_BORROW_CAP();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230328',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3PolygonAssets.WMATIC_UNDERLYING;
    assetsChanged[1] = AaveV3PolygonAssets.BAL_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(wMATIC, allConfigsAfter);
    _validateReserveConfig(bal, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230328',
      'post-Aave-V3-Polygon-Caps-Updates-20230328'
    );
  }
}
