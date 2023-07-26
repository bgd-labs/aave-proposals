---
title: Chaos Labs Risk Parameter Updates - CRV Aave V2 Ethereum
author: Chaos Labs (@ori-chaoslabs, @yonikesel)
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-crv-aave-v2-ethereum-2023-07-10/13952
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) and Loan-To-Value (LTV), for CRV on Aave V2 Ethereum.

## Motivation

Following our recommendations to decrease Aave’s exposure to CRV on V2 Ethereum [here](https://governance.aave.com/t/gauntlet-recommendation-to-freeze-crv-and-set-crv-ltv-0-on-aave-v2/13644/31), we propose a series of LT and LTV reductions. The [first reduction](https://app.aave.com/governance/proposal/255/) in this cycle of LT updates was executed on July 3rd, 2023. Since the initial post proposing to reduce the LTs for CRV, we’ve observed over 12M CRV withdrawn from V2 Ethereum.

In the Snapshot for this proposal , the community has voted on the "Aggressive" option:

1. “Aggressive” (Chaos recommended) - 6% reduction. This option suggests an LT configuration that optimizes the reduction without significantly increasing the number of accounts eligible for liquidation.

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 55            | 49             | -6%    |
| CRV   | LTV       | 49            | 43             | -6%    |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRVRiskParamsUpdate_20232507/AaveV2_Eth_CRVRiskParamsUpdate_20232507.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRVRiskParamsUpdate_20232507/AaveV2_Eth_CRVRiskParamsUpdate_20232507.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8b992ee05d9e87ef0dab2cb7178c24f7b4b6f5d79561ad33298550b3c8d9fe89)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-crv-aave-v2-ethereum-2023-07-10/13952)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
