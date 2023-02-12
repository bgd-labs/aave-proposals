// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * TODO: do actual wstETH once community decides so
 */
contract StEthPayload is IProposalGenericExecutor, Test {
  address public constant WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
  uint256 public constant WETH_CAP = 20_300;

  function execute() external override {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_CAP);
  }
}
