// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230610_Payload} from './AaveV3PolCapsUpdates_20230610_Payload.sol';

contract AaveV3PolCapsUpdates_20230518_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsUpdates_20230610_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 43687931);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    payload = new AaveV3PolCapsUpdates_20230610_Payload();
  }

  function testCapsUpdates() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-Aave-V3-Polygon-Caps-Updates-20230610',
      AaveV3Polygon.POOL
    );

    _executePayload(address(payload));

    ReserveConfig memory stMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );
    ReserveConfig memory MaticX = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    stMATIC.supplyCap = payload.NEW_SUPPLY_CAP_STMATIC();
    MaticX.supplyCap = payload.NEW_SUPPLY_CAP_MATICX();

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-Aave-V3-Polygon-Caps-Updates-20230610',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3PolygonAssets.stMATIC_UNDERLYING;
    assetsChanged[1] = AaveV3PolygonAssets.MaticX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(stMATIC, allConfigsAfter);
    _validateReserveConfig(MaticX, allConfigsAfter);

    diffReports(
      'pre-Aave-V3-Polygon-Caps-Updates-20230610',
      'post-Aave-V3-Polygon-Caps-Updates-20230610'
    );
  }
}
