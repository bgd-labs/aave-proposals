// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This steward sets supply caps for multiple assets on AAVE V3 Optimism
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf40a7b4a6ecd5325553593f0f9fdc8ba04808573fdf76fc277aee52b5396a588
 * - Dicussion: https://governance.aave.com/t/arc-v3-supply-cap-recommendations-for-uncapped-assets-fast-track/10750/6
 */
contract AaveV3OptCapsPayload is IProposalGenericExecutor {
  address public constant WETH = 0x4200000000000000000000000000000000000006;
  address public constant WBTC = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;
  address public constant LINK = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;

  //35.9K WETH
  uint256 public constant WETH_CAP = 35_900;
  //1.1K WBTC
  uint256 public constant WBTC_CAP = 1_100;
  //258K LINK
  uint256 public constant LINK_CAP = 258_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Optimism.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_CAP);

    configurator.setSupplyCap(WBTC, WBTC_CAP);

    configurator.setSupplyCap(LINK, LINK_CAP);
  }
}
