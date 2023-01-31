// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets borrow caps for multiple assets on AAVE V3 Arbitrum
 * - Snapshot: TBD //TODO
 * - Dicussion: https://governance.aave.com/t/arc-v3-borrow-cap-recommendations-fast-track-01-05-2022/10927
 */
contract AaveV3ArbBorrowCapsPayload is IProposalGenericExecutor {
  address public constant LINK = 0xf97f4df75117a78c1A5a0DBb814Af92458539FB4;
  address public constant WBTC = 0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f;
  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;

  uint256 public constant LINK_CAP = 242_249;
  uint256 public constant WBTC_CAP = 1_115;
  uint256 public constant WETH_CAP = 11_165;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setBorrowCap(LINK, LINK_CAP);

    configurator.setBorrowCap(WBTC, WBTC_CAP);

    configurator.setBorrowCap(WETH, WETH_CAP);
  }
}
