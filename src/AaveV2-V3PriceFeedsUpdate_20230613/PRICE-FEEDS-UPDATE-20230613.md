---
title: Price feeds operational update Pt2 - stETH
author: BGD Labs (@bgdlabs)
shortDescription: Swap price adapters for stETH and wstETH to use primary rate
discussions: https://governance.aave.com/t/bgd-operational-oracles-update/13213/9
created: 2023-06-13
---

## Simple Summary

This proposal further updates price feeds of LSTs (in this case stETH/wstETH) to be priced based on the so-called exchange rate, and not on the secondary market (e.g. DEXes).
The changes are the following:

- The feed of `stETH` on Aave v2 Ethereum will be a custom adapter, which will return 1:1 `stETH / ETH` value, as with stETH being a rebasing asset, that represents the stETH/ETH exchange rate.
- The feeds for `wstETH` on Aave v3 Ethereum, Optimism, and Arbitrum will be custom adapters too (CL synchronicity), using the `wstETH / stETH` exchange rate and `ETH / USD` feed

## Motivation

We assume the price of the `stETH` to be in the ration 1 to 1 to the price of the `ETH`, but the current price feed for `stETH` currently uses `stETH / ETH` feed, which is based on secondary market and can introduce additional unnecessary volatility of the asset. The same issue applies to the `wstETH` adapters, which are whether using a `stETH / ETH` or a `stETH / USD` feed inside.

To address the issue for `stETH` we are substituting the usage of the `stETH / ETH` feed by using the custom adapter, which returns constant 1:1 ratio.

For the `wstETH` adapters we are removing the usage of intermediate `stETH / ETH` feed or substituting `stETH / USD` for `ETH / USD` feed.

An update for wstETH on Aave v3 Polygon will be done in the close future to apply the same pricing strategy, once Chainlink provides a wstETH/stETH exchange rate feed.

## Specification

Upon execution, the proposal will:

- call `ORACLE.setAssetSources([0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84], [0xADE6CBA6c45aa8E9d0337cAc3D2619eabc39D901])` to replace the price source for `stETH` on Aave v2 Ethereum
- use Config Engine to update `wstETH` price feed to [0x8B6851156023f4f5A66F68BEA80851c3D905Ac93](https://etherscan.io/address/0x8b6851156023f4f5a66f68bea80851c3d905ac93) on Aave v3 Ethereum
- use Config Engine to update `wstETH` price feed to [0x945fD405773973d286De54E44649cc0d9e264F78](https://arbiscan.io/address/0x945fd405773973d286de54e44649cc0d9e264f78) on Aave v3 Optimism
- use Config Engine to update `wstETH` price feed to [0x80f2c02224a2E548FC67c0bF705eBFA825dd5439](https://optimistic.etherscan.io/address/0x80f2c02224a2e548fc67c0bf705ebfa825dd5439) on Aave v3 Arbitrum

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

Price Adapters: [stETH Ethereum v2](https://etherscan.io/address/0xade6cba6c45aa8e9d0337cac3d2619eabc39d901), [wstETH Ethereum v3](https://etherscan.io/address/0x8b6851156023f4f5a66f68bea80851c3d905ac93), [wstETH Optimism](https://optimistic.etherscan.io/address/0x80f2c02224a2e548fc67c0bf705ebfa825dd5439), [wstETH Arbitrum](https://arbiscan.io/address/0x945fd405773973d286de54e44649cc0d9e264f78)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
