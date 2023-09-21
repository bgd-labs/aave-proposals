// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title test
 * @author bgd labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_Test_20230921 is AaveV3PayloadEthereum {
  function _preExecute() internal override {}

  function borrowsUpdates() public pure override returns (IEngine.BorrowUpdate[] memory) {
    IEngine.BorrowUpdate[] memory borrowUpdates = new IEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      enabledToBorrow: ENABLED,
      flashloanable: DISABLED,
      stableRateModeEnabled: DISABLED,
      borrowableInIsolation: ENABLED,
      withSiloedBorrowing: ENABLED,
      reserveFactor: 10_00
    });

    return borrowUpdates;
  }
}
