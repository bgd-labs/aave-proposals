// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019} from './AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019.sol';

/**
 * @dev Test for AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019
 * command: make test-contract filter=AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019
 */
contract AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019_Test is ProtocolV2TestBase {
  AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 48882873);
    proposal = new AaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019();
  }

  function testProposalExecution() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019',
      AaveV2Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019',
      AaveV2Polygon.POOL
    );

    diffReports(
      'preAaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019',
      'postAaveV2_Polygon_ReserveFactorUpdateOctober2023_20231019'
    );

    address[] memory assetsChanged = new address[](7);
    assetsChanged[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    assetsChanged[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    assetsChanged[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    assetsChanged[4] = AaveV2PolygonAssets.WETH_UNDERLYING;
    assetsChanged[5] = AaveV2PolygonAssets.WMATIC_UNDERLYING;
    assetsChanged[6] = AaveV2PolygonAssets.BAL_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetsChanged.length; i++) {
      if (
        assetsChanged[i] == AaveV2PolygonAssets.BAL_UNDERLYING
      ) {
        continue;
      }
      ReserveConfig memory cfg = _findReserveConfig(allConfigsAfter, assetsChanged[i]);
      _deposit(cfg, AaveV2Polygon.POOL, address(42), 100);
    }
  }
}
