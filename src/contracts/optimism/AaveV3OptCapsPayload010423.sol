// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This governance payload set a supply cap for AAVE on AAVE V3 Optimism
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xaca5b7e014d4e752ce5ff0d0a1b1d9bf86496338d1ec53bfb0132810535f6db8
 * - Dicussion: https://governance.aave.com/t/arc-risk-parameter-updates-for-aave-v3-optimism-2022-12-29/11213
 */
contract AaveV3OptCapsPayload is IProposalGenericExecutor {
  address public constant AAVE = 0x76FB31fb4af56892A25e32cFC43De717950c9278;

  // 100k AAVE
  uint256 public constant AAVE_CAP = 100_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Optimism.POOL_CONFIGURATOR;

    configurator.setSupplyCap(AAVE, AAVE_CAP);
  }
}
