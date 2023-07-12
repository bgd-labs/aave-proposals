// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism, IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title List rETH on Aave V3 Optimism
 * @author Llama
 * @dev This proposal lists rETH on Aave V3 Optimism
 * Governance: https://governance.aave.com/t/arfc-add-reth-aave-v3-optimism/13795
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb112684943ef900f2918ccbc4de3bb3091869eaeb6b3c15cc26805c17cb6a9f6
 */
contract AaveV3OPListings_20230710_Payload is AaveV3PayloadOptimism {
  address public constant RETH = 0x9Bcef72be871e61ED4fBbc7630889beE758eb81D;
  address public constant RETH_PRICE_FEED = 0x52d5F9f884CA21C27E2100735d793C6771eAB793;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: RETH,
        assetSymbol: 'rETH',
        priceFeed: RETH_PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(45_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(7_00),
          variableRateSlope2: _bpsToRay(300_00),
          stableRateSlope1: _bpsToRay(13_00),
          stableRateSlope2: _bpsToRay(300_00),
          baseStableRateOffset: _bpsToRay(3_00),
          stableRateExcessOffset: _bpsToRay(5_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.DISABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 67_00,
        liqThreshold: 74_00,
        liqBonus: 7_50,
        reserveFactor: 15_00,
        supplyCap: 6_000,
        borrowCap: 720,
        debtCeiling: 0,
        liqProtocolFee: 10_00,
        eModeCategory: 2
      }),
      IEngine.TokenImplementations({
        aToken: AaveV3Optimism.DEFAULT_A_TOKEN_IMPL_REV_2,
        vToken: AaveV3Optimism.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_2,
        sToken: AaveV3Optimism.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_2
      })
    );

    return listings;
  }
}
