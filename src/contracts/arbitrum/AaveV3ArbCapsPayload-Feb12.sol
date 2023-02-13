// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This steward sets supply caps for multiple assets on AAVE V3 Arbitrum
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-and-arbitrum-2023-02-07/11605
 */
contract AaveV3ArbCapsPayload is IProposalGenericExecutor {
  address public constant WETH = AaveV3ArbitrumAssets.WETH_UNDERLYING;
  address public constant LINK = AaveV3ArbitrumAssets.LINK_UNDERLYING;

  uint256 public constant WETH_CAP = 35_280;
  uint256 public constant LINK_CAP = 677_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_CAP);

    configurator.setSupplyCap(LINK, LINK_CAP);
  }
}
