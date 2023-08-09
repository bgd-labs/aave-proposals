---
title: Treasury Management - Polygon v2 to v3 Migration 
discussions: https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248
author: TokenLogic
---

# Summary

This AIP shall redeem aTokens from Aave v2 Polygon and deposit the underlying assets into Aave v3 Polygon. 

# Motivation

On Polygon, Aave DAO is currently holding funds on the Aave v2 deployment and also some small unproductive allocations within the Treasury. This AIP will improve DAOs Treasury performance by improving the overall capital efficiency and yield being generated.

As part of broader v2 to v3 migration effort, this AIP shall implement the following:
* Claim Aave Paraswap fees to Collector via the Aave Paraswap Claimer
* Redeem Assets from Aave v2
* Deposit Assets from Aave v2 into v3

There are several small unproductive holdings within the Polygon Treasury. These assets will also be deposited into Aave v3 to earn yield.

* Deposit Assets held in Treasury into Aave v3

For reference, the Aave Polygon Treasury: [`0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383`](https://polygonscan.com/address/0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248)

* [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882)

* [Test Cases](XXX)

* [Payload Implementation](XXX)

* [Deployed Contracts](XXX)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

TokenLogic receives no payment from Aave DAO or any external source for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).