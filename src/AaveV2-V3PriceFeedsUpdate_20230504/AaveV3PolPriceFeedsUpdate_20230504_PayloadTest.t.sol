// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PolPriceFeedsUpdate_20230504_Payload} from './AaveV3PolPriceFeedsUpdate_20230504_Payload.sol';

contract AaveV3PolPriceFeedsUpdate_20230504_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 43016107);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3PolPriceFeedsUpdate_20230504_Payload payload = new AaveV3PolPriceFeedsUpdate_20230504_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3PolPriceFeedsUpdate_20230504Change', AaveV3Polygon.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3PolPriceFeedsUpdate_20230504_PayloadChange',
      AaveV3Polygon.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3PolygonAssets.stMATIC_UNDERLYING,
      payload.STMATIC_ADAPTER()
    );

    _validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      payload.MATICX_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3PolPriceFeedsUpdate_20230504Change',
      'postAaveV3PolPriceFeedsUpdate_20230504_PayloadChange'
    );
  }
}
