// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This steward sets supply caps for multiple assets on AAVE V3 Arbitrum
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-and-arbitrum-2023-02-07/11605
 */
contract AaveV3ArbCapsPayload is IProposalGenericExecutor {
  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;

  uint256 public constant WETH_CAP = 35_280;
  uint256 public constant LINK_CAP = 677_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_CAP);

    configurator.setSupplyCap(LINK, LINK_CAP);
  }
}
