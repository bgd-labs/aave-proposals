// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Test proposal
 * @author BGD labs
 * - Snapshot: https://test
 * - Discussion: https://test
 */
contract AaveV3Ethereum_TestProposal_20231006 is AaveV3PayloadEthereum {
  function _preExecute() internal override {}

  function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    capsUpdate[0] = IEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.WBTC_UNDERLYING,
      supplyCap: 100_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
