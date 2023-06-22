---
title: Add fUSDC to Ethereum v3
author: Marc Zeller (@marczeller), Aave-Chan initiative
shortDescription: Add fUSDC to Ethereum v3
discussions: https://governance.aave.com/t/arfc-add-fusdc-to-ethereum-v3/13180
created: 2022-06-05
---

## Simple Summary

This ARFC presents the community with the opportunity to add fUSDC to the Ethereum v3 Liquidity Pool.

## Motivation

fUSDC is a yield-bearing token representing USDC deposits in Flux, a fork of Compound V2. Adding fUSDC to Ethereum v3 would allow fUSDC holders to borrow stablecoins on Aave and leverage their fUSDC position, boosting the stablecoin utilization rate on Aave, while attracting new stablecoin deposits thanks to boosted supply rates.

## Specification

Ticker: fUSDC

Contract Address: [0x465a5a630482f3abd6d3b84b39b29b07214d19e5](https://etherscan.io/address/0x465a5a630482f3abd6d3b84b39b29b07214d19e5)

| Parameter                | Value          |
| ------------------------ | -------------- |
| Isolation Mode           | Yes            |
| Borrowable               | No             |
| Collateral Enabled       | Yes            |
| Supply Cap               | 220M (~$4.45M) |
| Borrow Cap               | N/A            |
| Debt Ceiling             | $1M            |
| LTV                      | 77%            |
| LT                       | 79%            |
| Liquidation Bonus        | 4.5%           |
| Liquidation Protocol Fee | 20%            |
| Variable Base            | 0.00%          |
| Variable Slope1          | 4.00%          |
| Variable Slope2          | 60.00%         |
| Uoptimal                 | 90.00%         |
| Reserve Factor           | 10.00%         |
| Stable Borrowing         | Disabled       |

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ethFUSDCListing_20230605/AaveV3ethFUSDCListing_20230605_test.t.sol)
- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ethFUSDCListing_20230605/AaveV3ethFUSDCListing_20230605.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
