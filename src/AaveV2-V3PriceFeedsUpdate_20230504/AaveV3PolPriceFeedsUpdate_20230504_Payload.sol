// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon, IEngine} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title stMatic and MaticX Price Feeds update
 * @author BGD Labs
 * @notice Change LSTs price feeds on the Aave Polygon v3 pool.
 * - Governance Forum Post: https://governance.aave.com/t/bgd-operational-oracles-update/13213
 */
contract AaveV3PolPriceFeedsUpdate_20230504_Payload is AaveV3PayloadPolygon {
  address public constant STMATIC_ADAPTER = address(0xEe96b77129cF54581B5a8FECCcC50A6A067034a1);
  address public constant MATICX_ADAPTER = address(0x0e1120524e14Bd7aD96Ea76A1b1dD699913e2a45);

  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory priceFeedUpdate = new IEngine.PriceFeedUpdate[](2);
    priceFeedUpdate[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.stMATIC_UNDERLYING,
      priceFeed: STMATIC_ADAPTER
    });
    priceFeedUpdate[1] = IEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.MaticX_UNDERLYING,
      priceFeed: MATICX_ADAPTER
    });

    return priceFeedUpdate;
  }
}
