---
title: CRV Aave V2 Ethereum - LT Reduction
author: Chaos Labs (@yonikesel, @ori-chaoslabs)
discussions: https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) for CRV on Aave V2 Ethereum.

## Motivation

Following the **[CRV V2 Ethereum Deprecation Plan](https://governance.aave.com/t/arfc-chaos-labs-crv-v2-ethereum-deprecation-plan/14364)** approved by the community and given the current market conditions and protocol usage, Chaos Labs and Gauntlet aligned on a 2% LT reduction.

Chaos originally proposed a 3% reduction, while Gauntlet proposed a 2% reduction. The individual analyses and considerations can be found below.

**As of today, this LT reduction will not make any account eligible for liquidation.**

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

### Chaos Labs Analysis

Chaos Labs recommends a 3% reduction, with the following impact on top CRV suppliers (used as collateral):

| Account                                    | Total Supply (USD) | Total CRV Supplied | Total CRV Supplied (USD) | Total Borrows | Health | Health After Change | CRV price that will trigger liquidation |
| ------------------------------------------ | ------------------ | ------------------ | ------------------------ | ------------- | ------ | ------------------- | --------------------------------------- |
| 0x7a16ff8270133f063aab6c9977183d9e72835428 | 58.18M             | 123.35M            | 58.18M                   | 14.78M        | 1.93   | 1.81                | 45%                                     |
| 0xc420c9d507d0e038bd76383aaadcad576ed0073c | 2.13M              | 4.52M              | 2.13M                    | 429.64K       | 2.44   | 2.28                | 56%                                     |
| 0xb5587a54ff7022ac218438720bdcd840a32f0481 | 1.86M              | 1.86M              | 875.55K                  | 1.15M         | 1.12   | 1.10                | 29%                                     |
| 0x279a7dbfae376427ffac52fcb0883147d42165ff | 888.56K            | 1.57M              | 741.14K                  | 420.51K       | 1.14   | 1.10                | 13%                                     |
| 0xaecdde1672f3f121b3a6c43a2e0b5dfc28f6224c | 558.8K             | 1.15M              | 558.8K                   | 233.88K       | 1.17   | 1.10                | 10%                                     |

### Gauntlet Analysis

Gauntlet recommends changing the LT from 49% to 47%. Given ~5% daily volatility for CRV, this will preserve a 3-std daily move buffer to historically maintained HF levels for the largest suppliers of CRV, which reduces the risk of unhealthy liquidations.

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 49            | 47             | -2%    |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230822_AaveV2_Eth_CRVAaveV2Ethereum_LTReduction/AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230822_AaveV2_Eth_CRVAaveV2Ethereum_LTReduction/AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
