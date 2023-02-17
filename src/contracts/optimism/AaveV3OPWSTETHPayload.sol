// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3ListingOptimism, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingOptimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal lists wstETH on Aave V3 Optimism
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0ddd9784d8ac59ffcabc8ce86d2993179e044eeb102df1644b5b58d04ff25e63
 * - Discussion: https://governance.aave.com/t/arc-add-wsteth-to-aave-v3-on-optimism/10932
 */
contract AaveV3OPWSTETHPayload is AaveV3ListingOptimism {
  address constant WSTETH = 0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb;
  address constant WSTETH_USD_FEED = 0x698B585CbC4407e2D54aa898B2600B53C68958f7;

  constructor() AaveV3ListingOptimism(IGenericV3ListingEngine(AaveV3Optimism.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: WSTETH,
      assetSymbol: 'wstETH',
      priceFeed: WSTETH_USD_FEED,
      rateStrategy: address(0), // TODO: deploy rate strategy
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
