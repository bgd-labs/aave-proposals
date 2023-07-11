// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Add GMX to Aave V3 Arbitrum
 * @author Llama
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x1751d8de3c549ee99fbc9c1286d9575c482c3e639500dcc027455c8742d48bc9
 * - Discussion: https://governance.aave.com/t/arfc-add-gmx-to-arbitrum-v3/13768
 */
contract AaveV3_Arb_Listings_20231107_Payload is AaveV3PayloadArbitrum {
  address public constant GMX = 0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a;
  address public constant GMX_PRICE_FEED = 0xDB98056FecFff59D032aB628337A4887110df3dB;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: GMX,
        assetSymbol: 'GMX',
        priceFeed: GMX_PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(45_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(9_00),
          variableRateSlope2: _bpsToRay(300_00),
          stableRateSlope1: _bpsToRay(13_00),
          stableRateSlope2: _bpsToRay(300_00),
          baseStableRateOffset: 0,
          stableRateExcessOffset: _bpsToRay(13_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.DISABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 45_00,
        liqThreshold: 55_00,
        liqBonus: 8_00,
        reserveFactor: 20_00,
        supplyCap: 110_000,
        borrowCap: 60_000,
        debtCeiling: 2_500_000,
        liqProtocolFee: 10_00,
        eModeCategory: 0
      }),
      IEngine.TokenImplementations({
        aToken: AaveV3Arbitrum.DEFAULT_A_TOKEN_IMPL_REV_2,
        vToken: AaveV3Arbitrum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
        sToken: AaveV3Arbitrum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2
      })
    );

    return listings;
  }
}
