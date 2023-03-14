// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolFreezeAGEURBorrow} from '../../contracts/polygon/AaveV3PolFreezeAGEURBorrow.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolFreezeAGEURBorrowTest is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolFreezeAGEURBorrow public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 40303920);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    ReserveConfig memory agEURConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.agEUR_UNDERLYING
    );
    agEURConfig.borrowingEnabled = false;

    // 1. deploy l2 payload
    proposalPayload = new AaveV3PolFreezeAGEURBorrow();

    // 2. execute l2 payload
    _executePayload(address(proposalPayload));

    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ProtocolV3TestBase._validateReserveConfig(agEURConfig, allConfigsAfter);
  }
}
