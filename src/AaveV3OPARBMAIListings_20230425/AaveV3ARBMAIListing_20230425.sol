// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Add MAI on Aave V3 Arbitrum
 * @author @MarcZeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xef9654757a0d1aaec6f970f444ce54cfb2d6c2af0ccbfeb9a182acd51919453c
 * - Discussion: https://governance.aave.com/t/arfc-add-mai-to-arbitrum-aave-v3-market/12759
 */

contract AaveV3ARBMAIListing_20230425 is AaveV3PayloadArbitrum {
  address public constant MAI_USD_FEED = 0x59644ec622243878d1464A9504F9e9a31294128a;
  address public constant MAI = 0x3F56e0c36d275367b8C502090EDF38289b3dEa0d;

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
      supplyCap: 4_800_000,
      borrowCap: 2_400_000,
      debtCeiling: 1_200_000,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
