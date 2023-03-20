// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import 'forge-std/console.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, InterestStrategyValues, ReserveConfig, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolMaticXSupplyCap03132023Payload} from '../../contracts/polygon/AaveV3PolMaticXSupplyCap03132023Payload.sol';
import {IDefaultInterestRateStrategy} from 'aave-v3-core/contracts/interfaces/IDefaultInterestRateStrategy.sol';
import {DataTypes} from 'aave-v3-core/contracts/protocol/libraries/types/DataTypes.sol';

contract AaveV3PolMaticXSupplyCap03132023PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolMaticXSupplyCap03132023Payload public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40307139);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);

    payload = new AaveV3PolMaticXSupplyCap03132023Payload();
  }

  function testExecute() public {
    createConfigurationSnapshot(
      'pre-MaticX-Aave-V3-Polygon-Supply-Cap-Update-03132023',
      AaveV3Polygon.POOL
    );

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);
    ReserveConfig memory maticx = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.MaticX_UNDERLYING
    );

    _executePayload(address(payload));

    ReserveConfig[] memory allConfigs = _getReservesConfigs(AaveV3Polygon.POOL);

    maticx.supplyCap = payload.NEW_SUPPLY_CAP();

    _validateReserveConfig(maticx, allConfigs);

    createConfigurationSnapshot(
      'post-MaticX-Aave-V3-Polygon-Supply-Cap-Update-03132023',
      AaveV3Polygon.POOL
    );

    diffReports(
      'pre-MaticX-Aave-V3-Polygon-Supply-Cap-Update-03132023',
      'post-MaticX-Aave-V3-Polygon-Supply-Cap-Update-03132023'
    );
  }
}
