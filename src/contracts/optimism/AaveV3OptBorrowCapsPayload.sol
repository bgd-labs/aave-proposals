// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from '../../interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets supply caps for multiple assets on AAVE V3 Optimism
 * - Snapshot: TBD //TODO
 * - Dicussion: https://governance.aave.com/t/arc-v3-borrow-cap-recommendations-fast-track-01-05-2022/10927
 */
contract AaveV3OptBorrowCapsPayload is IProposalGenericExecutor {
  address public constant LINK = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;
  address public constant WBTC = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;
  address public constant WETH = 0x4200000000000000000000000000000000000006;

  uint256 public constant LINK_CAP = 141_900;
  uint256 public constant WBTC_CAP = 605;
  uint256 public constant WETH_CAP = 19_745;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Optimism.POOL_CONFIGURATOR;

    configurator.setBorrowCap(LINK, LINK_CAP);

    configurator.setBorrowCap(WBTC, WBTC_CAP);

    configurator.setBorrowCap(WETH, WETH_CAP);
  }
}
