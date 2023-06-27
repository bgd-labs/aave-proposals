// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolPriceFeedsUpdate_20230626_Payload} from './AaveV3PolPriceFeedsUpdate_20230626_Payload.sol';

contract AaveV3PolPriceFeedsUpdate_20230626_PayloadTest is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'));
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3PolPriceFeedsUpdate_20230626_Payload payload = new AaveV3PolPriceFeedsUpdate_20230626_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot(
      'preAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      AaveV3Polygon.POOL
    );

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      AaveV3Polygon.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Polygon.POOL_ADDRESSES_PROVIDER,
      AaveV3PolygonAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3PolPriceFeedsUpdate_20230626_PayloadChange',
      'postAaveV3PolPriceFeedsUpdate_20230626_PayloadChange'
    );

    // 6. e2e
    address user = address(9999);
    uint256 amount = 3000 * 10e6;

    deal(AaveV3PolygonAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).approve(address(AaveV3Polygon.POOL), amount);
    AaveV3Polygon.POOL.deposit(AaveV3PolygonAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.expectRevert();
    AaveV3Polygon.POOL.borrow(AaveV3PolygonAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.stopPrank();
  }
}
