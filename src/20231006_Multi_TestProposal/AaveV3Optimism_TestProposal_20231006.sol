// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism, IEngine} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Test Proposal
 * @author BGD labs
 * - Snapshot: yay
 * - Discussion: https://link
 */
contract AaveV3Optimism_TestProposal_20231006 is AaveV3PayloadOptimism {
  function _preExecute() internal override {}

  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory priceFeedsUpdates = new IEngine.PriceFeedUpdate[](1);

    priceFeedsUpdates[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.LINK_UNDERLYING,
      priceFeed: 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84
    });

    return priceFeedsUpdates;
  }
}
