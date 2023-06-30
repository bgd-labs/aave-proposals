// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title wstETH Price Feed update
 * @author BGD Labs
 * @notice Change wstETH price feed on the Aave Polygon v3 pool.
 * - Governance Forum Post: https://governance.aave.com/t/bgd-operational-oracles-update/13213/9
 */
contract AaveV3PolPriceFeedsUpdate_20230626_Payload is AaveV3PayloadPolygon {
  // WSTETH / ETH / USD price adapter
  address public constant WSTETH_ADAPTER = 0xe34949A48cd2E6f5CD41753e449bd2d43993C9AC;

  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory priceFeedUpdate = new IEngine.PriceFeedUpdate[](1);
    priceFeedUpdate[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.wstETH_UNDERLYING,
      priceFeed: WSTETH_ADAPTER
    });

    return priceFeedUpdate;
  }
}
