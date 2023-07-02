## Simple Summary

A proposal to reduce Liquidation Threshold (LT) and Loan-To-Value (LTV) for CRV on Aave V3 Polygon.

## Motivation

As the market liquidity of CRV has seen a substantial decline following the initial Polygon V3 listing, this proposal seeks to address this by decreasing the liquidation threshold (LT) and loan-to-value ratio (LTV). The objective is to mitigate the risk exposure associated with CRV and diminish its borrowing power, thereby aligning it more accurately with the existing market climate.

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. We suggest reaching the desired settings with a series of incremental decreases to minimize this impact. This proposal recommends a slightly more aggressive reduction than the one discussed in the [Risk-Off Framework](https://snapshot.org/#/aave.eth/proposal/bafkreigdmcfmwvnxfolpds4xkdicgrszgmknig7pz2r2t37tltupdpyfu4) previously approved by the community, reducing the LT by 5%.

Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

In the graph below, we share data to quantify and visualize the effect of the recommended reductions on protocol users. At the time of writing this post, zero (0) accounts will be affected by the proposed decrease.

![CRV (2)|600x371](upload://pzE60mcB6ZzeMBVzalOnrxvzSFH.png)

## Specification

| Asset | Parameter | Current Value | Recommendation |
| ----- | --------- | ------------- | -------------- |
| CRV   | LT        | 80            | 75             |
| CRV   | LTV       | 75            | 70             |

## Next Steps

1. Following community feedback, submit the ARFC for a snapshot vote for final approval.
2. If consensus is reached, submit an Aave Improvement Proposal (AIP) to implement the proposed updates.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
