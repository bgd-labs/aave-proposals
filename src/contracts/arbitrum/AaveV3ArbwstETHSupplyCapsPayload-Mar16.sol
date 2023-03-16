// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Increase supply and borrow caps for wstETH Aave arbitrum V3
 * @author @yonikesel - ChaosLabs
 * - Snapshot: N/A Direct-to-AIP ARFC framework
 * - Dicussion: https://governance.aave.com/t/arfc-supply-and-borrow-caps-update-wsteth-v3-arbitrum/12309
 */

contract AaveV3ArbwstETHCapsPayload is IProposalGenericExecutor {
  uint256 public constant WSTETH_SUPPLY_CAP = 4_650;

  function execute() external {
    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      WSTETH_SUPPLY_CAP
    );
  }
}
