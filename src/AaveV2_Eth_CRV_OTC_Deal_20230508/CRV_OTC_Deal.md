---
title: aCRV OTC Deal
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-acquire-crv-with-treasury-usdt/14251
---

## Simple Summary

This ARFC proposes the strategic acquisition of CRV tokens using USDT from the Aave DAO treasury (collector contract). The acquisition aims to support the DeFi ecosystem and position Aave DAO strategically in the Curve wars, benefiting GHO secondary liquidity.

## Motivation

Recent events related to the `0x7a16ff8270133f063aab6c9977183d9e72835428` position on Aave V2 have presented the Aave DAO with an opportunity to support the DeFi ecosystem and make a strategic acquisition of CRV tokens. These tokens can be mobilized to incentivize GHO liquidity via locking them to gather Curve voting power and support a GHO-specific Gauge.

A 2M USDT worth of CRV acquisition would send a strong signal of DeFi supporting DeFi, while allowing the Aave DAO to strategically position itself in the Curve wars, benefiting GHO secondary liquidity.

The treasury balance and the predicted lower costs for service providers for the 2023-2024 budget would allow this strategic acquisition while maintaining a conservative stance with DAO treasury holdings.

## Specification

The proposal suggests using 2M aUSDT from the Aave DAO treasury to acquire 5M aCRV tokens from `0x7a16ff8270133f063aab6c9977183d9e72835428`

In terms of implementation, this AIP initiates a transferFrom() on the aCRV token contract to the Aave Collector, leveraging a previous approval() from `0x7a16ff8270133f063aab6c9977183d9e72835428` of 5M aCRV tokens to the Aave DAO treasury (collector contract).

Then, 2M aUSDT are withdrawn from the collector contract and mobilized to repay part of `0x7a16ff8270133f063aab6c9977183d9e72835428` USDT debt.

In case of lack of approval on aCRV tokens, the proposal will fail.


## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-acquire-crv-with-treasury-usdt/14251)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
