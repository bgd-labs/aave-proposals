---
title: "Aave BGD Phase 2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/aave-bored-ghosts-developing-phase-2/14484"
---

## Simple Summary

Approval for an engagement for services between the Aave DAO and BGD Labs, focused on development related tasks and with a duration of 6 months.

<br>

## Motivation

After a successful Aave <> BGD Phase 1 engagement, this proposal seeks for approval of a new engagement, with narrower scope, duration and budget, in line with the principles of progressive decentralization.

An extensive rationale and description of this Phase 2 can be found on the [Aave Governance forum](https://governance.aave.com/t/aave-bored-ghosts-developing-phase-2/14484), but for better visibility, these are the key aspects on the scope:

**Development**

- Maintain and improve all the Aave developer-experience tooling introduced in Phase I, including aave-address-book, aave-proposals, aave-helpers, and many others, present in the BGD Github org.
- Iterate over Aave Seatbelt, making it fully compatible with Aave Governance v3, generalize it more for upcoming networks with Aave instances, and introduce new ideas to improve governance assurance.
- Lead the development of new items involving changes in the Safety Module. More specifically, those already pre-approved by the community.
- Create aggregated workflows, by re-organizing repositories (protocol, tooling from BGD, etc). At the moment, there are a lot of developer resources scattered around, properly organizing them requires further work.
- Development of the killswitch component approved by the community.
- Maintain and iterate over the upcoming Aave Governance v3, a.DI and Robot systems, including:
    - Deployment of new voting machines
    - Support the community on assessment of new bridges, and enabling them via proposals.
    - Fix any potential problem found.
    - Maintain the new governance user interface.
    - Study technical ways of increasing voting participation.
- Batch a series of improvements for Aave v3, into an Aave v3.1 version: this will include an improvement of the liquidation mechanism, and potentially some periphery components. In addition, any bug fixing (Aave v2 and v3) would be included.
- Support and advice on deprecation of Aave v2, involving any (reasonable) development. Items included on the Aave v3 part of the scope could potentially be applied on v2.
- Lead the deployment of 3 new deployment candidates (EVM), apart from the 2 pending network analyses (zkEVM, zkSync), if fully approved by the community. *Extra networks will be evaluated case-by-case*.

<br>

**Development liaison for security, and quality assurance**

- Plan and coordinate all security resources for any development project of the community., both those executed by BGD and not. This includes also the evaluation of what should be reviewed, the parties involved in it, and asking for a budget to the DAO whenever required.
If a major project not executed by BGD appears, we will support it in a best-effort manner.
- Onboard Certora on governance proposal reviews. We think it is important to have additional expert parties involved in the governance proposals verification process, and healthier for decentralization.
We believe Certora, after years of collaboration in the ecosystem, is one of the only entities trustable for the task, if we support them with a light onboarding.
This will mean that what previously was done by BGD on the on-chain stage will be taken over by Certora (and included on their upcoming renewal), and is not included/billed in this scope.
- Act as the main reviewer of submissions on the upcoming Immunefi bug bounty program, pre-approved by the community, respecting the SLA requirements.
- Keep doing Aave governance proposals’ reviews, on the pre-on-chain stage. We will review all the “operational” projects as they appear (listings, parameters updates), but the timing on ad-hoc bigger projects appearing from other contributors will depend on the project itself.
- Provide network analysis for 3 new deployment candidates (if applicable), together with tackling the whole deployment and activation technical procedure. *Extra network analysis will be budgeted independently*.
- Execute an initial iteration of the proposed Aave Forest. At the moment (Phase I) we are finishing the evaluation of an initial set of Owls, but coordination and acting as a technical entity associated “natively” with Aave will be necessary.

<br>

**Development support for contributors/partners**

- Support any entity improving the Aave DAO documentation on all technical information.
- Act as technical point of contact for external partners and contributors of the DAO.

<br>

**The duration of the engagement is 6 months**, from the execution of this on-chain governance proposal, which acts as the binding agreement between the Aave DAO and BGD Labs.

<br>

**The budget requested is 1’900’000 USD in stablecoins and 6’000 AAVE, 60% paid upfront and the rest over a stream of 6 months**.

<br>

## Specification

The proposal payload does the following:

1. Releases the upfront payment component to BGD Labs: 1'140'000 aDAI v2 and 3'600 AAVE.
2. Migrates the aDAI v2 of the Aave Ethereum Collector to aDAI v3, in order to create an stream from Aave v3, following the principles of migration v2->v3 of the community.
3. Creates 2 streams for 6 months: 760'000 aDAI v3 and 2'400 AAVE.

<br>

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230828_AaveV3_Eth_AaveBGDPhase2/AaveV3_Ethereum_AaveBGDPhase2_20230828.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230828_AaveV3_Eth_AaveBGDPhase2/AaveV3_Ethereum_AaveBGDPhase2_20230828.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe72dd00eb1ab6223b87e5e1fa740c39b64bfef9b7ccb0939e53403c78a04b18e)
- [Discussion](https://governance.aave.com/t/aave-bored-ghosts-developing-phase-2/14484)

<br>

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
