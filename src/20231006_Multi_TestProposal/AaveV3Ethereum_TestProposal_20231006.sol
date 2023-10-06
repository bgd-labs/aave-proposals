// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Test Proposal
 * @author BGD labs
 * - Snapshot: yay
 * - Discussion: https://link
 */
contract AaveV3Ethereum_TestProposal_20231006 is AaveV3PayloadEthereum {
  function _preExecute() internal override {}

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      supplyCap: 100_000_000,
      borrowCap: 1_000
    });

    return capsUpdate;
  }
}
