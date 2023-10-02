
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  AaveV3Polygon,
  AaveV3PolygonAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {
  AaveV3PolygonUpdate20231002maticPayload
} from './AaveV3Polygon_20231002matic.sol';

contract AaveV3PolygonUpdate_20231002matic_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 48248174);
  }

  function testPolygon20231002maticUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonUpdate20231002matic',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory MaticX_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );
    ReserveConfig memory stMATIC_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3PolygonUpdate20231002maticPayload()),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolygonUpdate20231002matic',
      AaveV3Polygon.POOL
    );

    diffReports('preTestPolygonUpdate20231002matic', 'postTestPolygonUpdate20231002matic');

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3PolygonAssets.MaticX_UNDERLYING;
    assetsChanged[1] = AaveV3PolygonAssets.stMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      MaticX_UNDERLYINGBefore.ltv = 4500;
      MaticX_UNDERLYINGBefore.liquidationThreshold = 6200;
      _validateReserveConfig(MaticX_UNDERLYINGBefore, allConfigsAfter);
    }
    {
      stMATIC_UNDERLYINGBefore.ltv = 4500;
      stMATIC_UNDERLYINGBefore.liquidationThreshold = 6000;
      _validateReserveConfig(stMATIC_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Polygon.POOL);
  }
}