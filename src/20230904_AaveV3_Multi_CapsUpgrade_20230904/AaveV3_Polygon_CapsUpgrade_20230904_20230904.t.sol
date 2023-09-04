// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Polygon_CapsUpgrade_20230904_20230904} from './AaveV3_Polygon_CapsUpgrade_20230904_20230904.sol';

/**
 * @dev Test for AaveV3_Polygon_CapsUpgrade_20230904_20230904
 * command: make test-contract filter=AaveV3_Polygon_CapsUpgrade_20230904_20230904
 */
contract AaveV3_Polygon_CapsUpgrade_20230904_20230904_Test is ProtocolV3TestBase {
  AaveV3_Polygon_CapsUpgrade_20230904_20230904 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 47135218);
    proposal = new AaveV3_Polygon_CapsUpgrade_20230904_20230904();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Polygon_CapsUpgrade_20230904_20230904',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Polygon_CapsUpgrade_20230904_20230904',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.DPI_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory DPI = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.DPI_UNDERLYING
    );
    DPI.supplyCap = 2_460;
    _validateReserveConfig(DPI, allConfigsAfter);

//     e2eTestAsset(
//        AaveV3Polygon.POOL,
//        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.WMATIC_UNDERLYING),
//        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.DPI_UNDERLYING)
//        );

    diffReports(
      'preAaveV3_Polygon_CapsUpgrade_20230904_20230904',
      'postAaveV3_Polygon_CapsUpgrade_20230904_20230904'
    );
  }
}
