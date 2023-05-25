// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum, IEngine} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title cbETH Price Feed update
 * @author BGD Labs
 * @notice Change cbETH price feed on the Aave v3 pool.
 * - Governance Forum Post: https://governance.aave.com/t/bgd-generalised-price-sync-adapters/11416
 */
contract AaveV3EthPriceFeedsUpdate_20230504_Payload is AaveV3PayloadEthereum {
  // CBETH / ETH / USD price adapter
  address public constant CBETH_ADAPTER = address(0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C);

  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory priceFeedUpdate = new IEngine.PriceFeedUpdate[](1);
    priceFeedUpdate[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.cbETH_UNDERLYING,
      priceFeed: CBETH_ADAPTER
    });

    return priceFeedUpdate;
  }
}
