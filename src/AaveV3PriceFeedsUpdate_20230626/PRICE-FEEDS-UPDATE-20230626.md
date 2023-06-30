---
title: Price feeds operational update Pt2.5 - wstETH
author: BGD Labs (@bgdlabs)
discussions: https://governance.aave.com/t/bgd-operational-oracles-update/13213/9
---

## Simple Summary

This proposal further updates price feeds of LSTs (in this case wstETH) to be priced based on the so-called exchange rate, and not on the secondary market (e.g. DEXes).
The changes are the following:

- The feed for `wstETH` on Aave v3 Polygon will be custom adapter (CL synchronicity), using the `wstETH / stETH` exchange rate and `ETH / USD` feed

## Motivation

We assume the price of the `stETH` to be in the ration 1 to 1 to the price of the `ETH`, but the current price feed for `wstETH` currently uses `stETH / ETH` feed inside, which is based on secondary market and can introduce additional unnecessary volatility of the asset. We are removing the usage of intermediate `stETH / ETH` feed.

## Specification

Upon execution, the proposal will:

- use Config Engine to update `wstETH` price feed to [0xe34949A48cd2E6f5CD41753e449bd2d43993C9AC](https://polygonscan.com/address/0xe34949a48cd2e6f5cd41753e449bd2d43993c9ac) on Aave v3 Polygon

## Security and additional considerations

Custom price adapters are already widely used in the system for price-correlated assets and were [reviewed by the auditors](https://github.com/bgd-labs/cl-synchronicity-price-adapter).

- Comparing the answers between the new adapter and existing one showed that the difference did not exceed 1% during the last half of the year.

## References

Tests: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3PriceFeedsUpdate_20230626/AaveV3PolPriceFeedsUpdate_20230626_PayloadTest.t.sol)

Proposal payload implementation: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3PriceFeedsUpdate_20230626/AaveV3PolPriceFeedsUpdate_20230626_Payload.sol)

Price Adapters: [wstETH Polygon](https://polygonscan.com/address/0xe34949a48cd2e6f5cd41753e449bd2d43993c9ac)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
