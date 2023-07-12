// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadArbitrum, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title add ARB to Aave V3 Arbitrum Pool
 * @author Marc Zeller (@marczeller - Aave Chan Initiative)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x308439517ffc8faa8709db0b4a1d131d2402ee8a3282cb79adf890de6135ec98
 * - Discussion: https://governance.aave.com/t/arfc-add-arb-to-arbitrum-aave-v3/13225
 */

contract AaveV3_Arb_ARBListing_20231207 is AaveV3PayloadArbitrum {
  address public constant ARB_USD_FEED = 0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6;
  address public constant ARB = 0x912CE59144191C1204E64559FE8253a0e49E6548;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
      asset: ARB,
      assetSymbol: 'ARB',
      priceFeed: ARB_USD_FEED,
      rateStrategyParams: Rates.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      }),
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 50_00,
      liqThreshold: 60_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 20_000_000,
      borrowCap: 16_500_000,
      debtCeiling: 14_000_000,
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
