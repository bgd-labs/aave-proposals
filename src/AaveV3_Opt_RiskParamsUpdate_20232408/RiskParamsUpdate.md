---
title: Chaos Labs Risk Parameter Updates - Aave V3 Optimism - 2023.08.13
author: Chaos Labs
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-08-13/14466
---

## Simple Summary

A proposal to adjust five (3) total risk parameters, including Loan-to-Value, Liquidation Threshold, and Liquidation Bonus, across two (2) Aave V3 Optimism assets.

## Motivation

Chaos Labs’ Parameter Recommendation Platform runs hundreds of thousands of agent-based off-chain and on-chain simulations to examine how different Aave V3 risk parameters configurations would behave under adverse market conditions - and find the optimal values to maximize protocol borrow usage while minimizing losses from liquidations and bad debt. 

Please find more information on the parameter recommendation methodology [here](https://community.chaoslabs.xyz/aave/recommendations/methodology).

*Note: As a general guideline, we limit the proposed changes by +-3% for all parameters as a high/low bound for a given proposal. This ensures more controlled changes and allows us to analyze their effect on user behavior before recommending further amendments to the parameters if the optimal configuration is outside this range.*

You can also view the simulation results and breakdown for the different assets by clicking on them on this [page](https://community.chaoslabs.xyz/aave/recommendations).

The output of our simulations reveals an opportunity to reduce the LP for WBTC, and increase LT and LTV for wstETH on V3 Optimism, resulting in improved capital efficiency of the system, with a negligible effect on the projected VaR (95th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours) and EVaR (Extreme VaR, the 99th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours)

**Simulating all changes jointly yields a projected borrow increase of ~$130K, with negligible impact on Extreme VaR compared to simulations with the current parameters.**

### Liquidity Analysis:

Based on our analysis, we have determined that there is adequate on-chain liquidity to support any significant liquidations with the updated parameters.

### Positions Analysis

We have not identified any outsized positions that are actively affecting our recommendations.

### Recommendations

| Asset | Parameter | Current | Recommended | Change |
| --- | --- | --- | --- | --- |
| WBTC | Liquidation Penalty | 8.5% | 7.5% | -1% |
| wstETH | Liquidation Threshold | 79% | 80% | +1% |
| wstETH | Loan-to-Value | 70% | 71% | +1% |

## References

- Implementation: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Opt_RiskParamsUpdate_20232408/AaveV3_Opt_RiskParamsUpdate_20232408.sol)
- Tests: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Opt_RiskParamsUpdate_20232408/AaveV3_Opt_RiskParamsUpdate_20232408.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7568e17d2d7078686255a8fadf563e1f072abae0b79188a5b5b76852a6ebd63f)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-optimism-2023-08-13/14466/1)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).