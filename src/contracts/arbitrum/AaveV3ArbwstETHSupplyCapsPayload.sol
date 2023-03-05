// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title increase supply cap for wstETH Aave arbitrum V3
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: N/A Direct-to-AIP ARFC framework
 * - Dicussion: https://governance.aave.com/t/arfc-increase-supply-cap-for-wsteth-aave-arbitrum-v3/12163
 */

contract AaveV3ArbwstETHCapsPayload is IProposalGenericExecutor {
  address public constant WSTETH = AaveV3ArbitrumAssets.WSTETH_UNDERLYING;

  uint256 public constant WSTETH_CAP = 2_400;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Arbitrum.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WSTETH, WSTETH_CAP);
  }
}
