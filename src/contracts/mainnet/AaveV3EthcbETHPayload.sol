// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IGenericV3ListingEngine, AaveV3ListingEthereum} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';

contract AaveV3EthcbETHPayload is AaveV3ListingEthereum {
  address constant CBETH = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704;
  address constant CBETH_USD_FEED = address(0); // 0xF017fcB346A1885194689bA23Eff2fE6fA5C483b is cbETH/ETH

  constructor()
    AaveV3ListingEthereum(
      IGenericV3ListingEngine(AaveV3Ethereum.LISTING_ENGINE)
    )
  {}

  function getAllConfigs()
    public
    pure
    override
    returns (IGenericV3ListingEngine.Listing[] memory)
  {
    IGenericV3ListingEngine.Listing[]
      memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: CBETH,
      assetSymbol: 'cbETH',
      priceFeed: CBETH_USD_FEED,
      rateStrategy: 0x7b8Fa4540246554e77FCFf140f9114de00F8bB8D, // same as wstETH
      enabledToBorrow: false,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 71_00,
      liqThreshold: 74_00,
      liqBonus: 10_00,
      reserveFactor: 10_00,
      supplyCap: 15_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
