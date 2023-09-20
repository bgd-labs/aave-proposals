---
title: "Aave <> Immunefi program activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-immunefi-bug-bounty-program/14757"
---

## Simple Summary

This proposal approves the activation of the Aave <> Immunefi bug bounty program.

All the details about the program can be found on the associated governance forum post, and on the draft document [HERE](https://docs.google.com/document/d/1cst5Kx0N2t4PfyNAEpobH6dWUE2JKfo49dSjRMhelfY).

## Motivation

Having a continuous and updated bug bounty program is a really important component regarding security procedures of an ecosystem like Aave.

The [Immunefi platform](https://immunefi.com/) is a leader in the bug bounty space, adopted by multiple other blockchain protocols, and with a quite active network of security researches submitting reports.

Following the pre-approval on Snapshot, and within the context of our engagement, BGD has been working with Immunefi representatives to define and activate the program, respecting all the decentralized procedures of the Aave DAO, while keeping the maximum quality possible.


## Specification

The proposal event only emits an event, in order to leave on-chain trace of the binding agreement between the Aave DAO and Immunefi, to formally activate the bounty program.

The activation will happen once all operational details are finished by Immunefi, in coordination with the entities defined as reviewers of the DAO in this specific context.

As defined on the Aave governance forum, the reviewers will be ourselves ([BGD Labs](https://twitter.com/bgdlabs)) for all non-GHO aspects of Aave (Aave v2, v3, Safety Module, Aave Governance), and [Aave Companies](https://twitter.com/aaveaave) for GHO.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230920_AaveV3_Eth_AaveImmunefiActivation/AaveV3_Ethereum_AaveImmunefiActivation_20230920.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230920_AaveV3_Eth_AaveImmunefiActivation/AaveV3_Ethereum_AaveImmunefiActivation_20230920.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb477feee6d506be940154bc84278654f2863044854f80fca825b236253a97778)
- [Discussion](https://governance.aave.com/t/bgd-aave-immunefi-bug-bounty-program/14757)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
