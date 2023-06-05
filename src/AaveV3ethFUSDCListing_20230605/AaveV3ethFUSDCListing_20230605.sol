// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {AaveV3PayloadEthereum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title Add fUSDC on Aave V3 Ethereum
 * @author @MarcZeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x601a534cd51391823c842e54dda5b9cc2c2be50fcb0655f8f59811e6cd2bdaa9
 * - Discussion: https://governance.aave.com/t/arfc-add-fusdc-to-ethereum-v3/13180
 */

contract AaveV3ethFUSDCListing_20230605 is AaveV3PayloadEthereum {
  address public constant FUSDC_USD_FEED = 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6; // TO-DO add actual feed
  address public constant FUSDC = 0x465a5a630482f3abD6d3b84B39B29b07214d19e5;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: FUSDC,
      assetSymbol: 'FUSDC',
      priceFeed: FUSDC_USD_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(60_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(60_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 75_00,
      liqThreshold: 80_00,
      liqBonus: 4_50,
      reserveFactor: 20_00,
      supplyCap: 220_000_000,
      borrowCap: 0,
      debtCeiling: 1_000_000,
      liqProtocolFee: 20_00,
      eModeCategory: 0
    });

    return listings;
  }
}
