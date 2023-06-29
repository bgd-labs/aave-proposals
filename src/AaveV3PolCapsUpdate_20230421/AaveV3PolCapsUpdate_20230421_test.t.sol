// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveAddressBook.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolCapsUpdate_20230421} from './AaveV3PolCapsUpdate_20230421.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract AaveV3PolCapsUpdate_20230421_Test is ProtocolV3LegacyTestBase {
  AaveV3PolCapsUpdate_20230421 public proposalPayload;

  uint256 public constant EURS_BORROW_CAP = 1_500_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 41766783);
  }

  function testBorrowCapsArb() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolCapsUpdate_20230421Change',
      AaveV3Polygon.POOL
    );

    proposalPayload = new AaveV3PolCapsUpdate_20230421();

    GovHelpers.executePayload(
      vm,
      address(proposalPayload),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3PolCapsUpdate_20230421Change',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory eursConfig = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.EURS_UNDERLYING
    );
    eursConfig.borrowCap = EURS_BORROW_CAP;
    _validateReserveConfig(eursConfig, allConfigsAfter);

    diffReports('preAaveV3PolCapsUpdate_20230421Change', 'postAaveV3PolCapsUpdate_20230421Change');
  }
}
