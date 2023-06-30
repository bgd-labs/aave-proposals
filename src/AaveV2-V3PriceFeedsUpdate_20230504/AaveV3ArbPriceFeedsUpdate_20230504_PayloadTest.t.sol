// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3LegacyTestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbPriceFeedsUpdate_20230504_Payload} from './AaveV3ArbPriceFeedsUpdate_20230504_Payload.sol';

contract AaveV3ArbPriceFeedsUpdate_20230504_PayloadTest is ProtocolV3LegacyTestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 104611792);
  }

  function testPayload() public {
    AaveV3ArbPriceFeedsUpdate_20230504_Payload payload = new AaveV3ArbPriceFeedsUpdate_20230504_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3ArbPriceFeedsUpdate_20230504Change', AaveV3Arbitrum.POOL);

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR);

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3ArbPriceFeedsUpdate_20230504_PayloadChange',
      AaveV3Arbitrum.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER,
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3ArbPriceFeedsUpdate_20230504Change',
      'postAaveV3ArbPriceFeedsUpdate_20230504_PayloadChange'
    );

    // 6. e2e
    address user = address(9999);
    uint256 amount = 3000 * 10e6;

    deal(AaveV3ArbitrumAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).approve(address(AaveV3Arbitrum.POOL), amount);
    AaveV3Arbitrum.POOL.deposit(AaveV3ArbitrumAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV3Arbitrum.POOL.borrow(AaveV3ArbitrumAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.expectRevert();
    AaveV3Arbitrum.POOL.borrow(AaveV3ArbitrumAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.stopPrank();
  }
}
