// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IGenericV3ListingEngine, AaveV3ListingOptimism} from 'aave-helpers/v3-listing-engine/AaveV3ListingOptimism.sol';

/**
 * @title This proposal lists LUSD on Aave V3 Ethereum
 * @author @marczeller - Aave-Chan Initiative, @alyra - Alyra Promo satoshi
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4b91ed7efdedf61ff6e263007b6810e745bc5609e489de2190ed13ff841bc8c2
 * - Discussion: https://governance.aave.com/t/arfc-add-lusd-to-optimism-v3-market/12113
 */
contract AaveV3OptLUSDPayload is AaveV3ListingOptimism {
  address constant LUSD = 0xc40F949F8a4e094D1b49a23ea9241D289B7b2819;
  address constant LUSD_USD_FEED = 0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052;

  constructor() AaveV3ListingOptimism(IGenericV3ListingEngine(AaveV3Optimism.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: LUSD,
      assetSymbol: 'LUSD',
      priceFeed: LUSD_USD_FEED,
      rateStrategy: 0x15C1638A1e674Af9957F3de2E7bF140278Ee51B7,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 3_000_000,
      borrowCap: 1_210_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
