---
title: Set Aave V3 Debt Swap Adapter as a Flash Borrower
author: BGD labs
discussions: TODO
---

## Simple Summary
This AIP aims to set the `ParaswapDebtSwapAdapterV3GHO` as a flashBorrower on the ACLManager to provide users with
fee-less debt swaps.

## Motivation
Swapping debt is a convenient and useful feature that users of the Aave protocol should be able to enjoy without needing to pay extra fees. In particular, the use of a flashloan here is more akin to a debt-bearing flashloan, which is already fee-less. The adapter does not use debt-bearing flashloans in order to allow repaying the new debt with unused flashloaned funds as the debt is accrued at the end of the flashloan.

Furthermore, debt swap users are already paying interest for their debt, unlike atomic flashloan consumers, the use case is fundamentally different and charging a premium does not make sense.

## Specification

Set the `ParaswapDebtSwapAdapterV3GHO` at [address]() as a flashBorrower on the `ACLManager` contract at [address]().

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_DebtSwapFlashBorrower_20232607/AaveV3_Eth_DebtSwapFlashBorrower_20232607.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_DebtSwapFlashBorrower_20232607/AaveV3_Eth_DebtSwapFlashBorrower_20232607.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
