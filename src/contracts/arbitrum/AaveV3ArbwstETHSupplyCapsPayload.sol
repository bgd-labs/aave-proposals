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
  uint256 public constant WSTETH_CAP = 2_400;

  function execute() external {
    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      WSTETH_CAP
    );
  }
}
