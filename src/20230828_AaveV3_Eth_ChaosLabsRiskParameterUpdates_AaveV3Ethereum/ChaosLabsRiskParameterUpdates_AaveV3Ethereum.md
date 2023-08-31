---
title: "Chaos Labs Risk Parameter Updates _ Aave V3 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-ethereum-2023-08-25/14641"
---

## Simple Summary

A proposal to adjust seven (7) total risk parameters, including Loan-to-Value, Liquidation Threshold, and Liquidation Bonus, across four (4) Aave V3 Ethereum assets.

## Motivation

Chaos Labs’ Parameter Recommendation Platform runs hundreds of thousands of agent-based off-chain and on-chain simulations to examine how different Aave V3 risk parameters configurations would behave under adverse market conditions - and find the optimal values to maximize protocol borrow usage while minimizing losses from liquidations and bad debt.

Please find more information on the parameter recommendation methodology [here](https://community.chaoslabs.xyz/aave/recommendations/methodology).

_Note: As a general guideline, we limit the proposed changes by +-3% for all parameters as a high/low bound for a given proposal. This ensures more controlled changes and allows us to analyze their effect on user behavior before recommending further amendments to the parameters if the optimal configuration is outside this range._

You can also view the simulation results and breakdown for the different assets by clicking on them on this [page](https://community.chaoslabs.xyz/aave/risk/markets/Ethereum/recommendations).

The output of our simulations reveals an opportunity to optimize parameters for DAI, wstETH, rETH and cbETH on V3 Ethereum, resulting in improved capital efficiency of the system, with a negligible effect on the projected VaR (95th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours) and EVaR (Extreme VaR, the 99th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours)

In addition, for wstETH, rETH, and cbETH, we recommend adjusting the LTV, as the current spread between the LTV to LT for these assets, which were originally set for the conservative V3 Ethereum launch, is unjustifiably large. The new spread will be similar to that of WETH.

**Simulating all changes jointly yields a projected borrow increase of ~$2.5M, with no increase in VaR and Extreme VaR compared to simulations with the current parameters.**

### Liquidity Analysis:

Based on our analysis, we have determined that there is adequate on-chain liquidity to support any significant liquidations with the updated parameters.

### Positions Analysis

We have not identified any outsized positions that are actively affecting our recommendations.

### Recommendations

| Asset  | Parameter             | Current | Recommended | Change |
| ------ | --------------------- | ------- | ----------- | ------ |
| DAI    | Liquidation Penalty   | 4%      | 5%          | +1%    |
| WSTETH | Liquidation Threshold | 80%     | 81%         | +1%    |
| WSTETH | Loan-to-Value         | 69%     | 78.5%       | +9.5%  |
| cbETH  | Liquidation Threshold | 74%     | 77%         | +3%    |
| cbETH  | Loan-to-Value         | 67%     | 74.5%       | +7.5%  |
| rETH   | Liquidation Threshold | 74%     | 77%         | +3%    |
| rETH   | Loan-to-Value         | 67%     | 74.5%       | +7.5%  |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230828_AaveV3_Eth_ChaosLabsRiskParameterUpdates_AaveV3Ethereum/AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230828_AaveV3_Eth_ChaosLabsRiskParameterUpdates_AaveV3Ethereum/AaveV3_Ethereum_ChaosLabsRiskParameterUpdates_AaveV3Ethereum_20230828.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x5aff6836eb2e2e7a664ab996a75e115dc1d2362d32bd4b1a3d8d68b1833db702)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-ethereum-2023-08-25/14641)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
