---
title: "Chaos Labs Risk Parameter Updates Aave V3 Avalanche"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-avalanche-2023-09-06/14774/1"
---

## Simple Summary

A proposal to adjust five (5) total risk parameters, including Loan-to-Value, Liquidation Threshold and Liquidation Bonus across three (3) Aave V3 Avalanche assets.

## Motivation

Chaos Labs’ Parameter Recommendation Platform runs hundreds of thousands of agent-based off-chain and on-chain simulations to examine how different Aave V3 risk parameter configurations would behave under adverse market conditions - and find the optimal values to maximize protocol borrow usage while minimizing losses from liquidations and bad debt.

Please find more information on the parameter recommendation methodology [here](https://community.chaoslabs.xyz/aave/recommendations/methodology).

You can also view the simulation results and breakdown for the different assets by clicking on them on this [page](https://community.chaoslabs.xyz/aave/risk/markets/Avalanche/recommendations).

The output of our simulations reveals an opportunity to optimize parameters for WAVAX, sAVAX and LINK.e on V3 Avalanche, resulting in improved capital efficiency of the system, with a negligible effect on the projected VaR (95th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours) and EVaR (Extreme VaR, the 99th percentile of the protocol losses that will be accrued due to bad debt from under-collateralized accounts over 24 hours)

_Simulating all changes jointly yields a projected borrow increase of ~$26K, with a negligible increase in VaR and Extreme VaR compared to simulations with the current parameters._

### Liquidity Analysis:

Based on our analysis, we have determined that there is adequate on-chain liquidity to support any significant liquidations with the updated parameters.

### Positions Analysis

We have not identified any outsized positions that are actively affecting our recommendations.

### Recommendations

| Asset  | Parameter             | Current | Recommended | Change |
| ------ | --------------------- | ------- | ----------- | ------ |
| WAVAX  | Liquidation Bonus     | 10%     | 9%          | -1%    |
| sAVAX  | Liquidation Threshold | 30%     | 40%         | +10%   |
| sAVAX  | Loan-to-Value         | 20%     | 30%         | +10%   |
| LINK.e | Liquidation Threshold | 68%     | 71%         | +3%    |
| LINK.e | Loan-to-Value         | 53%     | 56%         | +3%    |

## References

- Implementation: [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/fe8b73665240261e942fc09ac29d0b7c620301f2/src/20230918_AaveV3_Ava_ChaosLabsRiskParameterUpdatesAaveV3Avalanche/AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.sol)
- Tests: [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/fe8b73665240261e942fc09ac29d0b7c620301f2/src/20230918_AaveV3_Ava_ChaosLabsRiskParameterUpdatesAaveV3Avalanche/AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0c7fc4246c5795a9d9901c08a9a8279e7e6ed1069f2155fe48239c92e4e43193)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-avalanche-2023-09-06/14774/1)
- Payload contract: [0xC4421Eaf9087aa0B8f453C130Dc024c3Eb3A34D7](https://snowtrace.io/address/0xc4421eaf9087aa0b8f453c130dc024c3eb3a34d7)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
