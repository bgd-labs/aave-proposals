```diff
diff --git a/reports/0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2_pre-cbETH.md b/reports/0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2_post-cbETH.md
index ad74e50..e4304c3 100644
--- a/reports/0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2_pre-cbETH.md
+++ b/reports/0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2_post-cbETH.md
@@ -11,6 +11,7 @@
 | DAI | 0x6B175474E89094C44Da98b954EedeAC495271d0F | 0x018008bfb33d285247A21d44E50697654f754e63 | 0x413AdaC9E2Ef8683ADf5DDAEce8f19613d60D1bb | 0xcF8d0c70c850859266f5C338b38F9D663181C314 | 18 | 6400 | 7700 | 10400 | 2000 | 1000 | true | true | false | 338000000 | 271000000 | 0 | 0 | 0x694d4cFdaeE639239df949b6E24Ff8576A00d1f2 | true | false | false |false |true |
 | LINK | 0x514910771AF9Ca656af840dff83E8264EcF986CA | 0x5E8C8A7243651DB1384C0dDfDbE39761E8e7E51a | 0x63B1129ca97D2b9F97f45670787Ac12a9dF1110a | 0x4228F8895C7dDA20227F6a5c6751b8Ebf19a6ba8 | 18 | 5000 | 6500 | 10750 | 1000 | 2000 | true | true | false | 24000000 | 13000000 | 0 | 0 | 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283 | true | false | false |false |true |
 | AAVE | 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9 | 0xA700b4eB416Be35b2911fd5Dee80678ff64fF6C9 | 0x268497bF083388B1504270d0E717222d3A87D6F2 | 0xBae535520Abd9f8C85E58929e0006A2c8B372F74 | 18 | 6000 | 7000 | 10750 | 1000 | 0 | true | false | false | 1850000 | 0 | 0 | 0 | 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283 | true | false | false |false |false |
+| cbETH | 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704 | 0x977b6fc5dE62598B08C85AC8Cf2b745874E8b78c | 0x82bE6012cea6D147B968eBAea5ceEcF6A5b4F493 | 0x0c91bcA95b5FE69164cE583A2ec9429A569798Ed | 18 | 6700 | 7400 | 10750 | 1000 | 1500 | true | true | false | 10000 | 1200 | 0 | 0 | 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283 | true | false | false |false |true |


 ## InterestRateStrategies
```

# Specification

The proposal payload uses the [GenericListingEngine](https://etherscan.io/address/0xC51e6E38d406F98049622Ca54a6096a23826B426#code) to perform a new asset listing with the following parameters:

```sol
IGenericV3ListingEngine.Listing({
      asset: CBETH,
      assetSymbol: 'cbETH',
      priceFeed: CBETH_USD_FEED,
      rateStrategy: 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 67_00,
      liqThreshold: 74_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 10_000,
      borrowCap: 1_200,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
});
```

## Configuration snapshot

What you can see here is a formatted excerpt of the configuration snapshot with the relevant configurations after proposal execution.
You can find the full snapshot in the proposal [repository](https://github.com/bgd-labs/aave-v3-crosschain-listing-template/blob/abe6847092a47956e312ce7e67edb307376bbcfa/reports/0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2_post-cbETH.md).

### Reserve Configurations

| symbol                                                                           |    ltv | liqThreshold | liqBonus | liqProtocolFee | reserveFactor | borrowingEnabled |    supplyCap |   borrowCap | eModeCategory | isFlashloanable |
| -------------------------------------------------------------------------------- | -----: | -----------: | -------: | -------------: | ------------: | ---------------: | -----------: | ----------: | ------------: | --------------- |
| [cbETH](https://etherscan.io/address/0xBe9895146f7AF43049ca1c1AE358B0541Ea49704) | 67.00% |       74.00% |    7.50% |            10% |           15% |             true | 10'000 cbETH | 1'200 cbETH |             - | true            |

### InterestRateStrategies

| strategy                                                                                                                   | BaseVariableBorrowRate | VariableRateSlope1 | VariableRateSlope2 | optimalUsageRatio | maxExcessUsageRatio | assets                  |
| -------------------------------------------------------------------------------------------------------------------------- | ---------------------: | -----------------: | -----------------: | ----------------: | ------------------: | ----------------------- |
| [0x24701A6368Ff6D2874d6b8cDadd461552B8A5283](https://etherscan.io/address/0x24701A6368Ff6D2874d6b8cDadd461552B8A5283#code) |                     0% |              7.00% |            300.00% |            45.00% |              55.00% | WBTC, LINK, AAVE, cbETH |

## Deployed Contracts

- [CLSynchronicityPriceAdapterPegToBase: cbETH/USD feed](https://etherscan.io/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731#code)
- [AaveV3EthcbETHPayload: ProposalPayload](https://etherscan.io/address/TBA#code)

## References

- [GenericV3ListingEngine](https://etherscan.io/address/0xC51e6E38d406F98049622Ca54a6096a23826B426#code)
- [Forum discussion](https://governance.aave.com/t/arc-add-support-for-cbeth/10425)
- [Snapshot vote](https://snapshot.org/#/aave.eth/proposal/0xcbb588f0030f7726da3d065a30c2500652bbd0def6ca5f5f17a82daca777578e)
