// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title Add MAI on Aave V3 Optimism
 * @author @MarcZeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5c5de0a7cb87170f6b0f28da20c079f9c89350125fffa9f80e0f60cc3c9d43ea
 * - Discussion: https://governance.aave.com/t/arfc-add-mai-to-optimism-aave-v3-pool/12765
 */

contract AaveV3OPMAIListing_20230425 is AaveV3PayloadOptimism {
  address public constant MAI_USD_FEED = 0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0;
  address public constant MAI = 0xdFA46478F9e5EA86d57387849598dbFB2e964b02;

  function newListings() public pure override returns (IEngine.Listing[] memory) {
    IEngine.Listing[] memory listings = new IEngine.Listing[](1);

    listings[0] = IEngine.Listing({
      asset: MAI,
      assetSymbol: 'MAI',
      priceFeed: MAI_USD_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 75_00,
      liqThreshold: 80_00,
      liqBonus: 5_00,
      reserveFactor: 20_00,
      supplyCap: 7_600_000,
      borrowCap: 2_500_000,
      debtCeiling: 1_900_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
