// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IGenericV3ListingEngine, AaveV3ListingEthereum} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';

contract AaveV3EthAddCRVPoolPayload is AaveV3ListingEthereum {
  address public constant INTEREST_RATE_STRATEGY = 0x76884cAFeCf1f7d4146DA6C4053B18B76bf6ED14;

  constructor() AaveV3ListingEthereum(IGenericV3ListingEngine(AaveV3Ethereum.LISTING_ENGINE)) {}

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV2EthereumAssets.CRV_UNDERLYING,
      assetSymbol: 'CRV',
      priceFeed: AaveV2EthereumAssets.CRV_ORACLE,
      rateStrategy: INTEREST_RATE_STRATEGY,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: true,
      withSiloedBorrowing: false,
      flashloanable: false,
      ltv: 55_00,
      liqThreshold: 61_00,
      liqBonus: 8_30,
      reserveFactor: 20_00,
      supplyCap: 62_500_000,
      borrowCap: 7_700_000,
      debtCeiling: 20_900_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
