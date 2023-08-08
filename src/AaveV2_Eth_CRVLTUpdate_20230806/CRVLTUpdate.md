---
title: Reduce CRV LT by 6%
author: Chaos Labs (@omeragoldberg)
discussions: https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/43
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) by 6%, for CRV on Aave V2 Ethereum.

## Motivation

Following our recommendations to decrease Aave’s exposure to CRV on V2 Ethereum [here](https://governance.aave.com/t/gauntlet-recommendation-to-freeze-crv-and-set-crv-ltv-0-on-aave-v2/13644/31), we propose a series of LT reductions. The [first reduction](https://app.aave.com/governance/proposal/255/) in this cycle of LT updates was executed on July 3rd, 2023.

This proposal was previously accepted by the community. However, after passing AIP, the change was [cancelled](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-crv-aave-v2-ethereum-2023-07-10/13952/12), as market environments were extremely unstable following the Vyper exploit.

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 55            | 49             | -6%    |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRVLTUpdate_20230806/AaveV2_Eth_CRVLTUpdate_20230806.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRVLTUpdate_20230806/AaveV2_Eth_CRVLTUpdate_20230806.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8b992ee05d9e87ef0dab2cb7178c24f7b4b6f5d79561ad33298550b3c8d9fe89)
- [Discussion](https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/43)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
