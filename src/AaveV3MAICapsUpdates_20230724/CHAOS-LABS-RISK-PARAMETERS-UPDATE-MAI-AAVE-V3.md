---
title: Chaos Labs Risk Parameter Update - MAI Aave V3
author: Chaos Labs (@ori-chaoslabs, @yonikesel)
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-mai-on-aave-v3-2023-7-23/14110
---

## Simple Summary

A proposal to reduce the Supply and Borrow Caps and Debt Ceiling for MAI on Aave V3 Polygon, Arbitrum and Optimism

## Motivation

In light of MAI's recent depegging and the insights provided in the [Chaos Labs - MAI Depeg Update ](https://governance.aave.com/t/chaos-labs-mai-depeg-update/14108), we propose a conservative approach, including a temporary reduction in both the supply and borrow caps as well as the debt ceilings. With consideration of the current usage on Aave and existing liquidity, we recommend implementing the following updates:

1. Set supply caps at the current supply in each deployment
2. Set borrow cap at the current borrow in each deployment
3. Set Debt Ceiling at 2\*(Liquidity within LB range / MAI LT)

Note: Final recommendations will be rounded for simplicity

### Recommendations

| Chain    | Current Supply Cap | Recommended Supply Cap | Current Borrow Cap | Recommended Borrow Cap | Current Debt Ceiling ($) | Recommended Debt Ceiling ($) |
| -------- | ------------------ | ---------------------- | ------------------ | ---------------------- | ------------------------ | ---------------------------- |
| Arbitrum | 4,800,000          | 325,000                | 2,400,000          | 250,000                | 1,200,000                | 100,000                      |
| Optimism | 7,600,000          | 650,000                | 2,500,000          | 525,000                | 1,900,000                | 130,000                      |
| Polygon  | 2,200,000          | 900,000                | 1,200,000          | 700,000                | 2,000,000                | 180,000                      |

Note: Given the current usage on Polygon, these recommendations effectively disable further usage of MAI as collateral.

## References

Tests: [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3MAICapsUpdates_20230724/AaveV3MultiMAICapsUpdates_20230724_Test.t.sol)

Proposal payload implementations:

[Arbitrum Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3MAICapsUpdates_20230724/AaveV3ArbMAICapsUpdates_20230724.sol)

[Optimism Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3MAICapsUpdates_20230724/AaveV3OptMAICapsUpdates_20230724.sol)

[Polygon Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3MAICapsUpdates_20230724/AaveV3PolMAICapsUpdates_20230724.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
