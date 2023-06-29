// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2PriceFeedsUpdate_20230504_Payload} from './AaveV2PriceFeedsUpdate_20230504_Payload.sol';

contract AaveV2PriceFeedsUpdate_20230504_PayloadTest is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17279230);
  }

  function testPayload() public {
    AaveV2PriceFeedsUpdate_20230504_Payload payload = new AaveV2PriceFeedsUpdate_20230504_Payload();

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV2PriceFeedsUpdate_20230504Change', AaveV2Ethereum.POOL);

    // 2. execute payload
    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV2PriceFeedsUpdate_20230504Change', AaveV2Ethereum.POOL);

    // 4. Verify payload:
    _validateAssetSourceOnOracle(
      AaveV2Ethereum.POOL_ADDRESSES_PROVIDER,
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      payload.WBTC_ADAPTER()
    );

    // 5. compare snapshots
    diffReports(
      'preAaveV2PriceFeedsUpdate_20230504Change',
      'postAaveV2PriceFeedsUpdate_20230504Change'
    );

    // 6. e2e
    address user = address(9999);
    uint256 amount = 40000 * 10e6;

    deal(AaveV2EthereumAssets.USDC_UNDERLYING, user, amount);

    vm.startPrank(user);

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(AaveV2Ethereum.POOL), amount);
    AaveV2Ethereum.POOL.deposit(AaveV2EthereumAssets.USDC_UNDERLYING, amount, user, 0);
    AaveV2Ethereum.POOL.borrow(AaveV2EthereumAssets.WBTC_UNDERLYING, 1 * 10e8, 2, 0, user);

    vm.expectRevert();
    AaveV2Ethereum.POOL.borrow(AaveV2EthereumAssets.WBTC_UNDERLYING, 1 * 10e8, 2, 0, user);

    vm.stopPrank();
  }
}
