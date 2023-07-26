// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title TODO
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Eth_DebtSwapFlashBorrower_20232607 {
  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(address(0)); // TODO: Add correct address for ParaswapDebtSwapAdapter
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(address(0)); // TODO: Add correct address for ParaswapDebtSwapAdapterV3GHO
  }
}
