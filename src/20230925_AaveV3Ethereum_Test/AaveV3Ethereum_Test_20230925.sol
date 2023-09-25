// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title test
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: te
 */
contract AaveV3Ethereum_Test_20230925 is AaveV3PayloadEthereum {
  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory priceFeedsUpdates = new IEngine.PriceFeedUpdate[](1);

    priceFeedsUpdates[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      priceFeed: 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84
    });

    return priceFeedsUpdates;
  }
}
