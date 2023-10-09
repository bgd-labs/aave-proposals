---
title: "GHO Funding"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-gho-funding/14887"
---

## Simple Summary

This publication aims to acquire GHO from secondary markets to support the Aave DAO's short-term funding requirements.

## Motivation

The primary objective of this publication is to shift Aave DAO's expenditure towards being nominated in GHO. The following outlines some potential use cases for GHO:

* 328,000 GHO allowance over 6 months [Aave Grants Continuation Proposal](https://governance.aave.com/t/temp-check-updated-aave-grants-continuation-proposal/14951)
* 550,000 GHO over 3 months[Aave Events & Sponsorship](https://governance.aave.com/t/temp-check-aave-events-sponsorship-budget/14953)
* 75,000 GHO over 3 months [Expansion of “Orbit”](https://governance.aave.com/t/arfc-expansion-of-orbit-a-dao-funded-delegate-platform-initiative/14785)
* 406,000 GHO over 3 months [GHO Liquidity Committee](https://governance.aave.com/t/temp-check-treasury-management-create-and-fund-gho-liquidity-committee/14800)
* TBA Future ACI Funding Request (Renewal mid-October)

Totaling 1,359,000 GHO plus future ACI budget.

This proposal is expected to acquire approximately $1.6M from secondary markets based on current holdings in the Ethereum Treasury.

## Specification
Using the Aave Swap Contract, convert the following asset holdings to GHO:

* [aDAI v2](https://etherscan.io/token/0x028171bca77440897b824ca71d1c56cac55b68a3?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)
* [TUSD](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)
* [BUSD](https://etherscan.io/token/0x4fabb145d64652a948d72533023f6e7a623c7c53?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)
* [370,000 aEthDAI v3](https://etherscan.io/token/0x018008bfb33d285247a21d44e50697654f754e63?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)
* [370,000 aUSDT v2](https://etherscan.io/token/0x3ed3b47dd13ec9a98b44e6204a523e766b225811?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)

The GHO will be transferred to the [Aave Ethereum Treasury](https://etherscan.io/address/0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c).

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Eth_GHOFunding/AaveV3_Ethereum_GHOFunding_20230926.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Eth_GHOFunding/AaveV3_Ethereum_GHOFunding_20230926.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb094cdc806d407d0cf4ea00e595ae95b8c145f77b77cce165c463326cc757639)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-gho-funding/14887)

# Disclosure

TokenLogic receives no payment from Aave DAO or any external source for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
