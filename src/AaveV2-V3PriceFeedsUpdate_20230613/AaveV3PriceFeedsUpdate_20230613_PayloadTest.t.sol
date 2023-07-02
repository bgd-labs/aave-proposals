// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3LegacyTestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3PriceFeedsUpdate_20230613_Payload} from './AaveV3PriceFeedsUpdate_20230613_Payload.sol';

contract AaveV3PriceFeedsUpdate_20230613_PayloadTest is ProtocolV3LegacyTestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17471270);
  }

  function testPayload() public {
    AaveV3PriceFeedsUpdate_20230613_Payload payload = new AaveV3PriceFeedsUpdate_20230613_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3PriceFeedsUpdate_20230613Change', AaveV3Ethereum.POOL);

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    createConfigurationSnapshot(
      'postAaveV3PriceFeedsUpdate_20230613_PayloadChange',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      payload.WSTETH_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV3PriceFeedsUpdate_20230613Change',
      'postAaveV3PriceFeedsUpdate_20230613_PayloadChange'
    );

    // 6. e2e
    address user = address(9999);
    uint256 amount = 3000 * 10e6;

    deal(AaveV3EthereumAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).approve(address(AaveV3Ethereum.POOL), amount);
    AaveV3Ethereum.POOL.deposit(AaveV3EthereumAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV3Ethereum.POOL.borrow(AaveV3EthereumAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.expectRevert();
    AaveV3Ethereum.POOL.borrow(AaveV3EthereumAssets.wstETH_UNDERLYING, 1 * 10e18, 2, 0, user);

    vm.stopPrank();
  }
}
