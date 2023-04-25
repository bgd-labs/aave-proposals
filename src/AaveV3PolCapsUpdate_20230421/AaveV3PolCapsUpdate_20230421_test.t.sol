// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolCapsUpdate_20230421} from './AaveV3PolCapsUpdate_20230421.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolCapsUpdate_20230421_Test is ProtocolV3TestBase, TestWithExecutor {
  AaveV3PolCapsUpdate_20230421 public proposalPayload;

  uint256 public constant EURS_BORROW_CAP = 1_500_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 41766783);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    createConfigurationSnapshot(
      'preAaveV3PolCapsUpdate_20230421Change',
      AaveV3Polygon.POOL
    );

    proposalPayload = new AaveV3PolCapsUpdate_20230421();

    _executePayload(address(proposalPayload));

    createConfigurationSnapshot(
      'postAaveV3PolCapsUpdate_20230421Change',
      AaveV3Polygon.POOL
    );

    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    ReserveConfig memory eursConfig = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.EURS_UNDERLYING
    );
    eursConfig.borrowCap = EURS_BORROW_CAP;
    ProtocolV3TestBase._validateReserveConfig(eursConfig, allConfigsAfter);

    diffReports(
      'preAaveV3PolCapsUpdate_20230421Change',
      'postAaveV3PolCapsUpdate_20230421Change'
    );
  }
}
