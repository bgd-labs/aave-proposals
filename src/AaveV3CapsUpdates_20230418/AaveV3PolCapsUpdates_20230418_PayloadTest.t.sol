// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230418_Payload} from './AaveV3PolCapsUpdates_20230418_Payload.sol';

contract AaveV3PolCapsUpdates_20230418_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsUpdates_20230418_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 41683005);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    payload = new AaveV3PolCapsUpdates_20230418_Payload();
  }

  function testPoolActivation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230418',
      AaveV3Polygon.POOL
    );

    _executePayload(address(payload));

    ReserveConfig memory stMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );

    stMATIC.supplyCap = payload.NEW_SUPPLY_CAP();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230418',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.stMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(stMATIC, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230418',
      'post-Aave-V3-Polygon-Caps-Updates-20230418'
    );
  }
}
