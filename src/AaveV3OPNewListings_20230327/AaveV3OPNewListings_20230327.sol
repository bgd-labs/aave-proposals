// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title LIST LUSD on Aave V3 Optimism
 * @author @MarcZeller - Aave-Chan Initiative, @alyra - Alyra Promo satoshi
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4b91ed7efdedf61ff6e263007b6810e745bc5609e489de2190ed13ff841bc8c2
 * - Discussion: https://governance.aave.com/t/arfc-add-lusd-to-optimism-v3-market/12113
 */

contract AaveV3OPNewListings_20230327 is AaveV3PayloadOptimism {
  address public constant LUSD_USD_FEED = 0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052;
  address public constant LUSD = 0xc40F949F8a4e094D1b49a23ea9241D289B7b2819;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: LUSD,
      assetSymbol: 'LUSD',
      priceFeed: LUSD_USD_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(87_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(87_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 3_000_000,
      borrowCap: 1_210_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      eModeCategory: 0
    });

    return listings;
  }
}
