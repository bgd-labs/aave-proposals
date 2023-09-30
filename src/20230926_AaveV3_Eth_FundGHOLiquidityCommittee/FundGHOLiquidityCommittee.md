---
title: "Fund GHO Liquidity Committee"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-manage-gho-liquidity-committee/14914"
---

## Simple Summary

This publication proposes the creation and funding of the GHO Liquidity Committee (GLC) for an initial 3-month period.

## Motivation

GHO is currently trading below its peg, with liquidity spread across various pools. To address this, the GLC will receive a budget of 5 ETH and 438,000 units of GHO with the primary objectives of:

* Improving the GHO peg
* Growing GHO liquidity

The GLC's responsibilities include distributing rewards across liquidity pools and strategies that support GHO. The GLC is initially established for a 3-month period.

## Specification

This proposal encompasses the following actions:

* Swap 438,000 aEthDAI to GHO via the Aave Swap Contract
* Transfer 5 ETH and 438,000 units of GHO to the GLC SAFE address

GLC SAFE Address: `0x205e795336610f5131Be52F09218AF19f0f3eC60`

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Eth_FundGHOLiquidityCommittee/AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Eth_FundGHOLiquidityCommittee/AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x219cf8fbfa806b396728b7bf11e635ac4833ce92c9ea8e34f24a686e3cf0d132)
- [Discussion](https://governance.aave.com/t/arfc-treasury-manage-gho-liquidity-committee/14914)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
