// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolygonSupplyCapStmatic_20230810} from './AaveV3PolygonSupplyCapStmatic_20230810.sol';

/**
 * @dev Test for AaveV3PolygonSupplyCapStmatic_20230810_Test
 * command: make test-contract filter=AaveV3PolygonSupplyCapStmatic_20230810_Test
 */
contract AaveV3PolygonSupplyCapStmatic_20230810_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46297694);
  }

  function testProposalExecution() public {
    AaveV3PolygonSupplyCapStmatic_20230810 proposal = 
      AaveV3PolygonSupplyCapStmatic_20230810(0xF28E5a2f04B6B74741579DaEE1fc164978D2d646);

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolygonSupplyCapStmatic_20230810',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(proposal),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3PolygonSupplyCapStmatic_20230810',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory stMaticConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.stMATIC_UNDERLYING
    );

    stMaticConfig.supplyCap = 57_000_000;

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.stMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(stMaticConfig, allConfigsAfter);

    e2eTestAsset(
        AaveV3Polygon.POOL,
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.MaticX_UNDERLYING),
        _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.stMATIC_UNDERLYING)
        );

    diffReports('preAaveV3PolygonSupplyCapStmatic_20230810', 'postAaveV3PolygonSupplyCapStmatic_20230810');
  }
}
