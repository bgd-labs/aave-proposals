// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IGenericV3ListingEngine, AaveV3ListingEthereum} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';

/**
 * @title This proposal lists USDT on Aave V3 Ethereum
 * @author @marczeller Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x81e8a39e2c0409b5aeb82e5ac367492759a60e93da15f7b64bd4560508400987
 * - Dicussion: https://governance.aave.com/t/arfc-add-usdt-to-ethereum-v3-market/11536
 */
contract AaveV3EthUSDTPayload is AaveV3ListingEthereum {
  address constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
  address constant USDT_USD_FEED = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;

  constructor() AaveV3ListingEthereum(IGenericV3ListingEngine(AaveV3Ethereum.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: USDT_USD_FEED,
      rateStrategy: 0xdd1BAC6A713c5b0EC42bA39D0c5e4582975DE6D6,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 200_000_000,
      borrowCap: 185_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings; 
  }
}
