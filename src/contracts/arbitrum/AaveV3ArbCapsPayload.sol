// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This steward sets supply caps for multiple assets on AAVE V3 Arbitrum
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf40a7b4a6ecd5325553593f0f9fdc8ba04808573fdf76fc277aee52b5396a588
 * - Dicussion: https://governance.aave.com/t/arc-v3-supply-cap-recommendations-for-uncapped-assets-fast-track/10750/6
 */
contract AaveV3ArbCapsPayload is IProposalGenericExecutor {
  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  address public constant WBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
  address public constant AAVE = 0xba5DdD1f9d7F570dc94a51479a000E3BCE967196;

  //20.3K WETH
  uint256 public constant WETH_CAP = 20_300;
  //2.1K WBTC
  uint256 public constant WBTC_CAP = 2_100;
  //350K LINK
  uint256 public constant LINK_CAP = 350_000;
  //2.5K AAVE
  uint256 public constant AAVE_CAP = 2_500;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_CAP);

    configurator.setSupplyCap(WBTC, WBTC_CAP);

    configurator.setSupplyCap(LINK, LINK_CAP);

    configurator.setSupplyCap(AAVE, AAVE_CAP);
  }
}
