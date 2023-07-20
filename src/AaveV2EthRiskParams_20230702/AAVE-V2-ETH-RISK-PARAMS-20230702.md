---
title: Chaos Labs Risk Parameter Updates - Aave V2 Ethereum
author: Chaos Labs (@ori-chaoslabs, @yonikesel)
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-6-23/13789
---

## Simple Summary

A proposal to reduce the Liquidation Threshold (LT) and Loan-To-Value (LTV) and increase Liquidation Bonus (LB) and Reserve Factors (RF) for eleven (11) frozen collateral assets on Aave V2 Ethereum.

## Motivation

In line with our ongoing commitment to reduce the potential risks associated with V2 markets, we suggest a phased reduction of the _frozen_ V2 markets, comprising low-to-medium cap assets with limited liquidity. The following proposal is the first step to reduce capital efficiency across V2 collateral assets, which will be followed up with more detailed plans for additional parameter updates for these assets.

### LT Reductions

Implementing a gradual decrease in LTs effectively diminishes the borrowing power for the existing markets.

- The community has aligned on the aggressive option, which suggests a LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of 8% from the closest LT figure which would trigger more substantial liquidations, as can be seen in the supporting graphs [here](https://chaos-labs.notion.site/Supporting-Data-ARFC-Chaos-Labs-Risk-Parameter-Updates-Aave-V2-Ethereum-2023-6-23-338308b47db34c30a92204805f2a1972?pvs=4).

| Asset  | Current LT | Rec LT | Value Liquidated | Accounts Liquidated |
| ------ | ---------- | ------ | ---------------- | ------------------- |
| BAL    | 70%        | 55%    | $60              | 5                   |
| BAT    | 70%        | 52%    | $610             | 6                   |
| CVX    | 45%        | 40%    | 0                | 1                   |
| DPI    | 70%        | 42%    | 0                | 0                   |
| ENJ    | 67%        | 60%    | $300             | 4                   |
| KNC    | 70%        | 1%     | $1,790           | 7                   |
| MANA   | 75%        | 62%    | $500             | 5                   |
| REN    | 60%        | 40%    | $1,800           | 6                   |
| xSUSHI | 65%        | 60%    | 0                | 0                   |
| YFI    | 65%        | 55%    | $500             | 2                   |
| ZRX    | 65%        | 45%    | $500             | 5                   |

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

### Reduce LTV to zero

Lowering the Loan-to-Value (LTV) ratio to zero can potentially curb borrowing by less sophisticated users. It's important to note that due to V2's design, users can bypass the LTV limit to borrow up to the LT value.

### RF Increase

Progressively increasing the reserve factors diminishes the interest rate for providing these assets and lowers the suppliers' incentive to supply the assets. In this proposal, we suggest an initial hike of 10% for all inactive assets.

### LB Increase

We recommend increasing the LB for all proposed assets (excluding BAL and CVX) to 10% to better incentivize liquidations and accommodate for low liquidity for the given assets.

## Specification

| Asset  | Cur LT | Rec LT\* | Current LTV | Rec LTV | Current RF | Rec RF | Current LB | Rec LB |
| ------ | ------ | -------- | ----------- | ------- | ---------- | ------ | ---------- | ------ |
| BAL    | 70%    | 55%      | 65%         | 0       | 20%        | 30%    | 8%         | 8%     |
| BAT    | 70%    | 52%      | 65%         | 0       | 20%        | 30%    | 7.5%       | 10%    |
| CVX    | 45%    | 40%      | 35%         | 0       | 20%        | 30%    | 8.5%       | 8.5%   |
| DPI    | 70%    | 42%      | 65%         | 0       | 20%        | 30%    | 7.5%       | 10%    |
| ENJ    | 67%    | 60%      | 60%         | 0       | 20%        | 30%    | 6%         | 10%    |
| KNC    | 70%    | 1%       | 60%         | 0       | 20%        | 30%    | 10%        | 10%    |
| MANA   | 75%    | 62%      | 61.5%       | 0       | 35%        | 45%    | 7.5%       | 10%    |
| REN    | 60%    | 40%      | 55%         | 0       | 20%        | 30%    | 7.5%       | 10%    |
| xSUSHI | 65%    | 60%      | 50%         | 0       | 35%        | 45%    | 8.5%       | 10%    |
| YFI    | 65%    | 55%      | 50%         | 0       | 20%        | 30%    | 7.5%       | 10%    |
| ZRX    | 65%    | 45%      | 55%         | 0       | 20%        | 30%    | 7.5%       | 10%    |

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthRiskParams_20230702/AaveV2EthRiskParams_20230702Test.t.sol)
- [Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthRiskParams_20230702/AaveV2EthRiskParams_20230702.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
