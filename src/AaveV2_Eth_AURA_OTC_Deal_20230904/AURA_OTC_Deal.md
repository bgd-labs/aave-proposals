---
title: AURA OTC Deal
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-treasury-management-acquire-aura/14683
---

## Simple Summary

This AIP proposes Aave DAO acquire 443,674 AURA from Olympus DAO for 420,159 units of DAI

## Motivation

Over the next few months the veBAL and vlAURA being used to support GHO pools will reduce as voters shift there focus away from GHO. The initial commit from the Aura Finance team was 400,000 units of vlAURA for an initial 3 month duration.

This proposal seeks to replace the support from Aura Finance by acquiring 443,674 units of AURA from Olympus DAO. Olympus DAO is reducing there AURA exposure due to change in the Olympus DAO roadmap which is detailed [here](https://forum.olympusdao.finance/d/3756-towards-a-fully-autonomous-olympus) and [here](https://forum.olympusdao.finance/d/3967-tap29-aura-solicitation-to-bid).

Based upon the research presented in this [Update Balancer Ecosystem Holdings](https://governance.aave.com/t/temp-check-update-balancer-ecosystem-holdings/14682), which details impact AIP-42 by Aura Finance, the most efficient way for Aave DAO to bootstrap GHO is via vlAURA relative to veBAL.

Olympus DAO seeks payment in DAI, at an exchange rate of 0.9470 DAI per unit of AURA. The amount of AURA is 443,674 with a total cost to Aave DAO of 420,159 units of DAI. Aave DAO currently holds [2.873M](https://etherscan.io/token/0x028171bca77440897b824ca71d1c56cac55b68a3?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) units of aDAI on Aave v2.

## Specification

This proposal will achieve the following:

- Redeem 420,159 units aDAI from Aave v2
- Exchange 420,159 units of DAI for 443,674 units of AURA with Olympus DAO

For reference, Olympus DAO AURA Holding Address: `0x245cc372C84B3645Bf0Ffe6538620B04a217988B`

The contract was developed in collaboration with @MarcZeller and deployed by the ACI team.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xeb88691a23f3b1f9dfb4d2fb575fa19e75050a67b80b23eff91c0d430a177bd1)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-acquire-aura/14683)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
