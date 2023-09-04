// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Polygon_SupplyCapLSTs_20230831} from './AaveV3_Polygon_SupplyCapLSTs_20230831.sol';

/**
 * @dev Test for AaveV3_Polygon_SupplyCapLSTs_20230831
 * command: make test-contract filter=AaveV3_Polygon_SupplyCapLSTs_20230831
 */
contract AaveV3_Polygon_SupplyCapLSTs_20230831_Test is ProtocolV3TestBase {
  AaveV3_Polygon_SupplyCapLSTs_20230831 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46981463);
    proposal = new AaveV3_Polygon_SupplyCapLSTs_20230831();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Polygon_SupplyCapLSTs_20230831',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Polygon_SupplyCapLSTs_20230831',
      AaveV3Polygon.POOL
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3PolygonAssets.stMATIC_UNDERLYING;
    assetsChanged[1] = AaveV3PolygonAssets.wstETH_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory stMATIC = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );
    stMATIC.supplyCap = 66_000_000;
    _validateReserveConfig(stMATIC, allConfigsAfter);

    ReserveConfig memory wstETH = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.wstETH_UNDERLYING
    );
    wstETH.supplyCap = 4125;
    _validateReserveConfig(wstETH, allConfigsAfter);

     e2eTestAsset(
        AaveV3Polygon.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.WMATIC_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.stMATIC_UNDERLYING)
        );

     e2eTestAsset(
        AaveV3Polygon.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.WMATIC_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.wstETH_UNDERLYING)
        );

    diffReports(
      'preAaveV3_Polygon_SupplyCapLSTs_20230831',
      'postAaveV3_Polygon_SupplyCapLSTs_20230831'
    );
  }
}