// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IPriceOracleSentinel} from 'aave-v3-core/contracts/interfaces/IPriceOracleSentinel.sol';
import {AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload} from './AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload.sol';

contract AaveV3OptPriceFeedsSentinelUpdate_20230504_PayloadTest is
  ProtocolV3TestBase,
  TestWithExecutor
{
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'));
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload payload = new AaveV3OptPriceFeedsSentinelUpdate_20230504_Payload();
    IPriceOracleSentinel priceOracleSentinel = IPriceOracleSentinel(
      payload.PRICE_ORACLE_SENTINEL()
    );

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3OptPriceFeedsUpdate_20230504Change', AaveV3Optimism.POOL);

    // 2. execute payload
    _executePayload(address(payload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3OptPriceFeedsUpdate_20230504_PayloadChange',
      AaveV3Optimism.POOL
    );

    // 4. Verify oracle is updated:
    _validateAssetSourceOnOracle(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3OptimismAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. Verify price oracle sentinel
    assertEq(
      address(priceOracleSentinel),
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3OptPriceFeedsUpdate_20230504Change',
      'postAaveV3OptPriceFeedsUpdate_20230504_PayloadChange'
    );

    // 6. e2e
    address user = address(9999);
    uint256 amount = 3000 * 10e6;

    deal(AaveV3OptimismAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).approve(address(AaveV3Optimism.POOL), amount);
    AaveV3Optimism.POOL.deposit(AaveV3OptimismAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV3Optimism.POOL.borrow(AaveV3OptimismAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.expectRevert();
    AaveV3Optimism.POOL.borrow(AaveV3OptimismAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.stopPrank();
  }
}
