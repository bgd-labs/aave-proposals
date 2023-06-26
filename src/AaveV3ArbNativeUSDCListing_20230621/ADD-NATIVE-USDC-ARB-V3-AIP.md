---
title: Add Native USDC To Arbitrum V3 Pool
author: Marc Zeller (@marczeller), Aave-Chan initiative
discussions: https://governance.aave.com/t/arfc-add-native-usdc-to-the-arbitrum-v3-pool/13568
---

## Simple Summary

This AIP propose to add the native USDC token issued by Circle to the Arbitrum V3 pool.
Currently onboarded USDC.e token will be kept as is and two USDC tokens will be available on the pool. The bridged asset USDC.e and the native USDC with the symbol USDCn.

## Motivation

Circle has launched a native version of USDC on Arbitrum, which is anticipated to become the primary version of the USDC stablecoin on the Arbitrum L2. This will supersede the current “USDC.e” token, which is a bridged asset with an underlying USDC on Ethereum.

From our experience with the Avalanche Pool, we’ve learned that a prudent approach to integrating such a native token involves initially onboarding it with parameters similar to its bridged counterpart, but with more conservative caps. As the native USDC builds secondary liquidity and matures, we can gradually decrease the attractiveness of USDC.e and increase the caps for the native USDC.

This ARFC is focused solely on the onboarding of the native USDC and does not propose any action for USDC.e. As a result, if this proposal is accepted by the governance, both USDC.e and the native USDC will be onboarded simultaneously on the Arbitrum V3 pool. This strategy aims to ensure a smooth transition and maintain the stability of the Aave V3 pool on Arbitrum.

## Specification

### Token Information

- Token Symbol: USDC
- Token Address: [0xaf88d065e77c8cC2239327C5EDb3A432268e5831](https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831)

The implementation of the token is the same as the one used for the USDC.e token.
The payload use a custom engine to avoid compatibility issues with the current USDC.e token and protocol version.

while the protocol code use "USDCn" to distinguish both versions of the token. we recommend that UI supports USDCn with the symbol "USDC" to avoid confusion.

Likewise, What the protocol consider "USDC" will be shown as "USDC.e" on the UI.

```solidity
contract AaveV3ArbNativeUSDCListing_20230621 is AaveV3PayloadArbitrum {
  address public constant USDCN = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
  address public constant USDCN_PRICE_FEED =
    0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[]
      memory listings = new IEngine.ListingWithCustomImpl[](1);

    listings[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: USDCN,
        assetSymbol: "USDCn",
        priceFeed: USDCN_PRICE_FEED,
        rateStrategyParams: Rates.RateStrategyParams({
          optimalUsageRatio: _bpsToRay(90_00),
          baseVariableBorrowRate: 0,
          variableRateSlope1: _bpsToRay(3_50),
          variableRateSlope2: _bpsToRay(60_00),
          stableRateSlope1: _bpsToRay(5_00),
          stableRateSlope2: _bpsToRay(60_00),
          baseStableRateOffset: _bpsToRay(1_00),
          stableRateExcessOffset: _bpsToRay(8_00),
          optimalStableToTotalDebtRatio: _bpsToRay(20_00)
        }),
        enabledToBorrow: EngineFlags.ENABLED,
        stableRateModeEnabled: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.ENABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.ENABLED,
        ltv: 81_00,
        liqThreshold: 86_00,
        liqBonus: 5_00,
        reserveFactor: 10_00,
        supplyCap: 41_000_000,
        borrowCap: 41_000_000,
        debtCeiling: 0,
        liqProtocolFee: 10_00,
        eModeCategory: 1
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
```

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ArbNativeUSDCListing_20230621/AaveV3ArbNativeUSDCListing_20230621Test.sol)
- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ArbNativeUSDCListing_20230621/AaveV3ArbNativeUSDCListing_20230621.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
