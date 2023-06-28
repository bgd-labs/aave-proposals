---
title: Chaos Labs Risk Parameter Updates - CRV Aave V2 Ethereum
author: Chaos Labs (@ori-chaoslabs, @yonikesel)
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-crv-aave-v2-ethereum-2023-06-15/13709
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) and Loan-To-Value (LTV), for CRV on Aave V2 Ethereum.

## Motivation

Following our recommendations to decrease Aave’s exposure to CRV on V2 Ethereum [here](https://governance.aave.com/t/gauntlet-recommendation-to-freeze-crv-and-set-crv-ltv-0-on-aave-v2/13644/31), we propose a series of LT and LTV reductions.

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. To best minimize this impact, we suggest reaching the desired settings by a series of incremental decreases, following the [Risk-Off Framework](https://snapshot.org/#/aave.eth/proposal/bafkreigdmcfmwvnxfolpds4xkdicgrszgmknig7pz2r2t37tltupdpyfu4) previously approved by the community, with a reduction of up to 3% in any given AIP. In an attempt to avoid liquidations, Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

In the graph below, we share data to quantify and visualize the effect of the recommended reductions on protocol users. For the proposed, 3% LT decrease, the impact on users at the time of this post is negligible (2 accounts liquidated, ~3$ liquidated).

| Liquidation Treshold | Accounts Liquidated | Liquidation Value |
| -------------------- | ------------------- | ----------------- |
| 55                   | 2                   | ~3$               |

## Specification

| Asset | Parameter | Current | Recommended | Change |
| ----- | --------- | ------- | ----------- | ------ |
| CRV   | LT        | 58      | 55          | -3%    |
| CRV   | LTV       | 52      | 49          | -3%    |

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2CRVRiskParams_20230621/AaveV2CRVRiskParams_20230621Test.t.sol)
- [Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2CRVRiskParams_20230621/AaveV2CRVRiskParams_20230621.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
