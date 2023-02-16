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
  address public constant WSTETH = 0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb;
  address public constant WST_ETH_PRICE_FEED = 0x698B585CbC4407e2D54aa898B2600B53C68958f7;

  constructor() AaveV3ListingOptimism(IGenericV3ListingEngine(AaveV3Optimism.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: WSTETH,
      assetSymbol: 'wstETH',
      priceFeed: WST_ETH_PRICE_FEED,
      rateStrategy: address(0), // TODO!
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: false,
      ltv: 70_00,
      liqThreshold: 79_00,
      liqBonus: 7_20,
      reserveFactor: 15_00,
      supplyCap: 6_000,
      borrowCap: 940,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
