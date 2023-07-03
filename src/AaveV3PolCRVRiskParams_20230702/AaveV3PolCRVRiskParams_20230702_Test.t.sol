// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PolCRVRiskParams_20230702} from './AaveV3PolCRVRiskParams_20230702.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3PolCRVRiskParams_20230702_Test is ProtocolV3TestBase {
  uint256 public constant CRV_UNDERLYING_LIQ_THRESHOLD = 75_00;
  uint256 public constant CRV_UNDERLYING_LTV = 70_00;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 44593763);
  }

  function testPayload() public {
    AaveV3PolCRVRiskParams_20230702 proposalPayload = new AaveV3PolCRVRiskParams_20230702();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolCRVRiskParams_20230702Change',
      AaveV3Polygon.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(proposalPayload),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3PolCRVRiskParams_20230702Change',
      AaveV3Polygon.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.CRV_UNDERLYING
    );

    CRV_UNDERLYING_CONFIG.liquidationThreshold = CRV_UNDERLYING_LIQ_THRESHOLD;
    CRV_UNDERLYING_CONFIG.ltv = CRV_UNDERLYING_LTV;

    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3PolCRVRiskParams_20230702Change',
      'postAaveV3PolCRVRiskParams_20230702Change'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3PolygonAssets.CRV_UNDERLYING
    );
  }
}
