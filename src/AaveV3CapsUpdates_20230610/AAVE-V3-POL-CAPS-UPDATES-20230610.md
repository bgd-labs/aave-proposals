---
title: Polygon Supply Cap Update
discussions: https://governance.aave.com/t/arfc-polygon-v3-supply-cap-update-2023-05-21/13161
shortDescription: Increase SupplyCap stMATIC and MaticX on Polygon v3 from 30M units to 40M units and 29.3M to 38M units respectively.
author: Llama (Fermin Carranza and TokenLogic)
created: 2023-06-08
---

# Summary

This AIP increases the stMATIC and MaticX Supply Cap on Polygon to 40M units and 38M units respectively.

# Abstract

The utilisation of the stMATIC and MaticX Supply Caps has reached 100% and is preventing strategies built on Aave Protocol from depositing into these reserves.

The yield maximising strategy is currently incentivised by two communities, Polygon Foundation and Stader Labs. These incentives encourage users to deposit either Liquid Staking Token (LST) into Aave v3 Protocl.

This AIP, with support from Chaos Labs and a favourable Snapshot, shall increase the Supply Caps to enable users to deposit funds in the stMATIC and MaticX reserves on Polygon v3.

# Motivation

Over the previous months, Llama has been working with various communities to craft favourable conditions on Aave v3 Polygon to facilitate the creation of several yield aggregation products. These products are now active with more soon to be deployed.

With conservative Supply Caps being implemented and filled within minutes, or hours, communities who have built products on Aave v3 are experiencing great frustration. After investing time, resources and incurring audit costs, these communities are unable to promote their products to prospective users without the newly implemented Supply Caps being filled.

For these integrations to be successful, the Supply Caps need to be increased such that a wide array of prospective users can enter into these automated strategies. Currently, the smaller Supply Cap increases are filling quickly and we are experiencing several whales / products absoring near 100% of newly implemented Supply Caps is not promoting a desirable UX for users.

The original ARFC links below:

- [MaticX Forum Post](https://governance.aave.com/t/arfc-polygon-supply-cap-update-23-05-2023/13190)
- [stMATIC Forum Post](https://governance.aave.com/t/arfc-polygon-v3-supply-cap-update-2023-05-21/13161)

The proposed Supply Caps are supported by Chaos Labs. However, Gauntlet has a more conservative risk model which limits the Supply Cap to 50% of supply on the network relative to Chaose Lab's 75%. This difference leads to differing Supply Cap recommendations. Do note, Aave DAO voted to increase the Supply Caps to [75%](https://snapshot.org/#/aave.eth/proposal/0xf9261916c696ce2d793af41b7fe556896ed1ff7a8330b7d0489d5567ebefe3ba) of supply. A Snapshot vote for each Supply Cap is linked below:

- [MaticX Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbbb92805d7b15d46d668cdc8e40d9a15e6a3ed2ac94802667e7d3c35a763bc8c)
- [stMATIC Snapshop](https://snapshot.org/#/aave.eth/proposal/0xd0e157ef44b5429df7e412126d632afa1192f84fa6045dcdcaed61bc79ad1b45)

The community has shown clear support for increasing the Supply Caps in line with the original.

The stMATIC and MaticX Supply Cap on Polygon to 40M units and 38M units respectively.

# Specification

The following risk parameters changes are presented:

**Polygon**

Ticker: stMATIC

Contract: [`0x3a58a54c066fdc0f2d55fc9c89f0415c92ebf3c4`](https://polygonscan.com/address/0x3a58a54c066fdc0f2d55fc9c89f0415c92ebf3c4)

| Parameter | Current Value    | Proposed Value   |
| --------- | ---------------- | ---------------- |
| SupplyCap | 32,000,000 units | 40,000,000 units |

Ticker: MaticX

Contract: [`0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6`](https://polygonscan.com/address/0xfa68fb4628dff1028cfec22b4162fccd0d45efb6)

| Parameter | Current Value    | Proposed Value   |
| --------- | ---------------- | ---------------- |
| SupplyCap | 29,300,000 units | 38,000,000 units |

# Implementation

A list of relevant links like for this proposal:

- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3CapsUpdates_20230610/AaveV3PolCapsUpdates_20230610_PayloadTest.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3CapsUpdates_20230610/AaveV3PolCapsUpdates_20230610_Payload.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
