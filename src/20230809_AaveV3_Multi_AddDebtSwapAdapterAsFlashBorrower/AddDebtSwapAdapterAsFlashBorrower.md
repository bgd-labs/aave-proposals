---
title: "Add DebtSwapAdapter as FlashBorrower"
author: "BGD labs"
discussions: "https://governance.aave.com/t/bgd-grant-flashborrower-role-to-debtswapadapter-s/14595"
---

## Simple Summary

This AIP aims to set the `ParaswapDebtSwapAdapterV3GHO` as a flashBorrower on the `ACLManager` in each relevant network to provide users with fee-less debt swaps.

## Motivation

Swapping debt is a convenient and useful feature that users of the Aave protocol should be able to enjoy without needing to pay extra fees. In particular, the use of a flashloan here is more akin to a debt-bearing flashloan, which is already fee-less. The adapter does not use debt-bearing flashloans in order to allow repaying the new debt with unused flashloaned funds as the debt is accrued at the end of the flashloan.

Furthermore, debt swap users are already paying interest for their debt, unlike atomic flashloan consumers, the use case is fundamentally different and charging a premium does not make sense.

## Specification

Set the `ParaswapDebtSwapAdapterV3GHO` as a flashBorrower on the `ACLManager` contract on Ethereum, Optimism, Arbitrum, Polygon, Avalanche and Base.

On Ethereum, the adapter address is [0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68](https://etherscan.io/address/0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68) and the ACLManager address is [0xc2aaCf6553D20d1e9d78E365AAba8032af9c85b0.](https://etherscan.io/address/0xc2aaCf6553D20d1e9d78E365AAba8032af9c85b0)

On Optimism, the adapter address is [0xcFaE0D8c5707FCc6478D6a65fFA31efADeF8b8EC](https://optimistic.etherscan.io/address/0xcFaE0D8c5707FCc6478D6a65fFA31efADeF8b8EC) and the ACLManager address is [0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B.](https://optimistic.etherscan.io/address/0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B)

On Arbitrum, the adapter address is [0x9E8e9D6b0D24216F59043db68BDda1620892f549](https://arbiscan.io/address/0x9E8e9D6b0D24216F59043db68BDda1620892f549) and the ACLManager address is [0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B.](https://arbiscan.io/address/0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B)

On Polygon, the adapter address is [0xb58Fd91558fa213D97Ac94C97F831c7289278084](https://polygonscan.com/address/0xb58Fd91558fa213D97Ac94C97F831c7289278084) and the ACLManager address is [0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B.](https://polygonscan.com/address/0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B)

On Avalanche, the adapter address is [0x8A9b2c132EA7676EE267F5b97b622083d6E3a2d4](https://snowtrace.io/address/0x8A9b2c132EA7676EE267F5b97b622083d6E3a2d4) and the ACLManager address is [0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B.](https://snowtrace.io/address/0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B)

On Base, the adapter address is [0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731](https://basescan.org/address/0x5f4d15d761528c57a5C30c43c1DAb26Fc5452731) and the ACLManager address is
[0x43955b0899Ab7232E3a454cf84AedD22Ad46FD33.](https://basescan.org/address/0x43955b0899Ab7232E3a454cf84AedD22Ad46FD33)

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809.sol), [Base](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Ethereum_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol), [Base](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230809_AaveV3_Multi_AddDebtSwapAdapterAsFlashBorrower/AaveV3_Base_AddDebtSwapAdapterAsFlashBorrower_20230809.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-grant-flashborrower-role-to-debtswapadapter-s/14595)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
