// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3LegacyTestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3OptPriceFeedsUpdate_20230613_Payload} from './AaveV3OptPriceFeedsUpdate_20230613_Payload.sol';

contract AaveV3OptPriceFeedsUpdate_20230613_PayloadTest is ProtocolV3LegacyTestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 105888970);
  }

  function testPayload() public {
    AaveV3OptPriceFeedsUpdate_20230613_Payload payload = new AaveV3OptPriceFeedsUpdate_20230613_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3OptPriceFeedsUpdate_20230613Change', AaveV3Optimism.POOL);

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3OptPriceFeedsUpdate_20230613_PayloadChange',
      AaveV3Optimism.POOL
    );

    // 4. Verify oracle is updated:
    _validateAssetSourceOnOracle(
      AaveV3Optimism.POOL_ADDRESSES_PROVIDER,
      AaveV3OptimismAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3OptPriceFeedsUpdate_20230613Change',
      'postAaveV3OptPriceFeedsUpdate_20230613_PayloadChange'
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
