// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IGenericV3ListingEngine, AaveV3ListingOptimism} from 'aave-helpers/v3-listing-engine/AaveV3ListingOptimism.sol';

/**
 * @title List wstETH on AaveV3Optimism
 * @author Llama
 * @dev This proposal lists wstETH on Aave V3 Optimism
 * Governance: https://governance.aave.com/t/arc-add-wsteth-to-aave-v3-on-optimism/10932
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0ddd9784d8ac59ffcabc8ce86d2993179e044eeb102df1644b5b58d04ff25e63
 */
contract AaveV3OptWSTETHListingPayload is AaveV3ListingOptimism {
  constructor() AaveV3ListingOptimism(IGenericV3ListingEngine(AaveV3Optimism.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);
  }
}
