---
title: Supply Cap Update - stMATIC Polygon v3
author: TokenLogic
discussions: https://governance.aave.com/t/arfc-supply-cap-stmatic-polygon/14355
---

# Summary

This publication proposes increasing the stMATIC Supply Cap on Polygon from 40.0M to 57M units.

# Motivation

Demand for stMATIC continues to steadily grow over time. This proposal will increase the Supply Cap and enable Aave Protocol to continue growing TVL through stMATIC deposits and revenue from users who who use stMATIC as collateral.

The utilisation of the stMATIC reserve has reached >90% and this publication proposes increasing the SupplyCap by a further 42.54% to 57M units.

The Polygon Foundation is currently providing stMATIC and MaticX rewards to users who borrow wMATIC. This supplements the borrow costs of wMATIC and enhances the yield on the yield maximising strategy.

Outside of Aave Protocol, incentives are provided at the strategy level with a number of integrations being advanced by other teams built on top of Aave using stMATIC as a yield source.

# Specification

The following risk parameters changes are presented:

**Polygon** 

Ticker: stMATIC

Contract: [`0x3a58a54c066fdc0f2d55fc9c89f0415c92ebf3c4`](https://polygonscan.com/address/0x3a58a54c066fdc0f2d55fc9c89f0415c92ebf3c4)

|Parameter|Current Value|Proposed Value|
| --- | --- | --- |
|SupplyCap|40,000,000M units|57,000,000 units|

This is equivalent to 75% of stMATIC supply on Polygon. 

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-supply-cap-stmatic-polygon/14355)
* [Test Cases](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveV3PolygonSupplyCapStmatic_20230810/AaveV3PolygonSupplyCapStmatic_20230810.t.sol)
* [Payload Implementation](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveV3PolygonSupplyCapStmatic_20230810/AaveV3PolygonSupplyCapStmatic_20230810.sol)
* [Deployed Contracts](https://polygonscan.com/address/0xf28e5a2f04b6b74741579daee1fc164978d2d646#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclosure

This proposal is the work of @TokenLogic. TokenLogic is a voting delegate within the Aave Ecosystem. TokenLogic receives no payment for this work.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).