---
title: stETH/wstETH price feeds update
author: BGD Labs (@bgdlabs)
shortDescription: Swap price adapters for stETH and wstETH
discussions:
created: 2023-06-13
---

## Simple Summary

This proposal changes the following price adapters:

- `stETH` on Ethereum v2 to the custom adapter, which will return 1:1 `stETH / ETH` value
- `wstETH` on Ethereum, Optimism and Arbitrum v3 to the custom adapter, which uses `wstETH / stETH` ratio and `ETH / USD` feed

## Motivation

We assume the price of the `stETH` to be in the ration 1 to 1 to the price of the `ETH`, but the current price feed for `stETH` currently uses `stETH / ETH` feed, which is based on secondary market and can introduce additional unnecessary volatility of the asset. The same issue applies to the `wstETH` adapters, which are whether using `stETH / ETH` or `stETH / USD` feed inside.

To address the issue for `stETH` we are substituting the usage of the `stETH / ETH` feed by using the custom adapter, which returns constant 1:1 ratio.

For the `wstETH` adapters we are removing the usage of intermeiate `stETH / ETH` feed or substituting `stETH / USD` for `ETH / USD` feed.

## Specification

Upon execution, the proposal will:

- call `ORACLE.setAssetSources([0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599], [])` to replace the price source for `stETH` on Aave v2
- use Config Engine to update `wstETH` price feed to []() on Ethereum v3
- use Config Engine to update `wstETH` price feed to []() on Optimism
- use Config Engine to update `wstETH` price feed to []() on Arbitrum

## Security and additional considerations

Custom price adapters are already widely used in the system for price-correlated assets and were [reviewed by the auditors](https://github.com/bgd-labs/cl-synchronicity-price-adapter).

- **stETH / ETH Historical Comparison**: Comparing the ratio between `stETH` and `ETH` on the secondary market for the last half of a year:

  - 30.96% of results differ for less than 0.1%
  - 66.16% have between 0.1% and 0.5% difference
  - 2.88% is between 0.5% and 1%

The same pattern applies to the deviation between new and existing `wstETH / USD` adapters.

Previously there were two major depeg events for the `stETH`:

- In November 2022 difference was ~2% due to the FTX events and then got back to normal in about a month
- In June 2022 deviation was about ~7% due to Terra events + withdrawals were not allowed yet at the moment

## References

Tests: [Ethereum V2](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV2PriceFeedsUpdate_20230613_PayloadTest.t.sol), [Ethereum V3](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3PriceFeedsUpdate_20230613_PayloadTest.t.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3OptPriceFeedsUpdate_20230613_PayloadTest.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3ArbPriceFeedsUpdate_20230613_PayloadTest.t.sol)

Proposal payload implementation: [Ethereum V2](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV2PriceFeedsUpdate_20230613_Payload.sol), [Ethereum V3](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3PriceFeedsUpdate_20230613_Payload.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3OptPriceFeedsUpdate_20230613_Payload.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2-V3PriceFeedsUpdate_20230613/AaveV3ArbPriceFeedsUpdate_20230613_Payload.sol)

Price Adapters: [stETH Ethereum v2](), [wstETH Ethereum v3](), [wstETH Optimism](), [wstETH Arbitrum]()

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
