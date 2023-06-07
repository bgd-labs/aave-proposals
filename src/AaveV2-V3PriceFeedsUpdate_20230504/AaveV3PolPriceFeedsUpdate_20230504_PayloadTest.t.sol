// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
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

    // 6. e2e maticX
    address user = address(9999);
    uint256 amount = 1000 * 10e6;

    deal(AaveV3PolygonAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).approve(address(AaveV3Polygon.POOL), amount);
    AaveV3Polygon.POOL.deposit(AaveV3PolygonAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.MaticX_UNDERLYING, 800 * 10e18, 2, 0, user);

    vm.expectRevert();
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.MaticX_UNDERLYING, 100 * 10e18, 2, 0, user);

    vm.stopPrank();

    // 6. e2e stMatic
    vm.prank(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.stMATIC_UNDERLYING,
      40_000_000
    );

    address user2 = address(8888);
    uint256 amount2 = 1000 * 10e18;

    deal(AaveV3PolygonAssets.stMATIC_UNDERLYING, user2, amount2);

    vm.startPrank(user2);

    IERC20(AaveV3PolygonAssets.stMATIC_UNDERLYING).approve(address(AaveV3Polygon.POOL), amount2);
    AaveV3Polygon.POOL.deposit(AaveV3PolygonAssets.stMATIC_UNDERLYING, amount2, user2, 0);
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.USDC_UNDERLYING, 450 * 10e6, 2, 0, user2);

    vm.expectRevert();
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.stMATIC_UNDERLYING, 100 * 10e6, 2, 0, user2);

    vm.stopPrank();
  }
}
