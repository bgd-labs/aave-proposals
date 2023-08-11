// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Pol_wstETH_CapsIncrease_20230908} from './AaveV3_Pol_wstETH_CapsIncrease_20230908.sol';

/**
 * @dev Test for AaveV3_Pol_wstETH_CapsIncrease_20230908
 * command: make test-contract filter=AaveV3_Pol_wstETH_CapsIncrease_20230908
 */
contract AaveV3_Pol_wstETH_CapsIncrease_20230908_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 46109994);
  }

  function testProposalExecution() public {
    AaveV3_Pol_wstETH_CapsIncrease_20230908 proposal = new AaveV3_Pol_wstETH_CapsIncrease_20230908();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Pol_wstETH_CapsIncrease_20230908',
      AaveV3Polygon.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Pol_wstETH_CapsIncrease_20230908',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory wstETH = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.wstETH_UNDERLYING
    );

    wstETH.supplyCap = proposal.NEW_SUPPLY_CAP();

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.wstETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    _validateReserveConfig(wstETH, allConfigsAfter);

    e2eTestAsset(
      AaveV3Polygon.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.WETH_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.wstETH_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Pol_wstETH_CapsIncrease_20230908',
      'postAaveV3_Pol_wstETH_CapsIncrease_20230908'
    );
  }
}
