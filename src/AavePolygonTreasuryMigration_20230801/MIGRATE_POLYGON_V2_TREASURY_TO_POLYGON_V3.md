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
* Redeem Assets from Aave v2
* Deposit Assets from Aave v2 into v3

* Deposit Assets held in Treasury into Aave v3

For reference, the Aave Polygon Treasury: [`0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383`](https://polygonscan.com/address/0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)

# Specification

Transfer the following assets from Aave v2 to v3. The quantities in this table will change over time between proposal submission & proposal execution, and should not be taken as exact.

|Network|Instance|Token|Quantity|
|---|---|---|---|
|Polygon|Aave V2|AMUSDC|3,775,623.68|
|Polygon|Aave V2|AMDAI|3,380,138.80|
|Polygon|Aave V2|AMUSDT|1,379,093.97|
|Polygon|Aave V2|AMWETH|230.91|
|Polygon|Aave V2|AMWMATIC|106,528.66|
|Polygon|Aave V2|AMBAL|1,336.76|
|Polygon|Aave V2|AMCRV|9,404.00|
|Polygon|Aave V2|AMWBTC|0.09|
|Polygon|Aave V2|AMGHST|1,918.59|
|Polygon|Aave V2|AMLINK|33.56|

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248)

* [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882)

* [Test Cases](https://github.com/bgd-labs/aave-proposals/tree/main/src/AavePolygonTreasuryMigration_20230801/AavePolygonTreasuryMigration_20230801.t.sol)

* [Payload Implementation](https://github.com/bgd-labs/aave-proposals/tree/main/src/AavePolygonTreasuryMigration_20230801/AavePolygonTreasuryMigration_20230801.sol)

* [Deployed Contracts](https://polygonscan.com/address/0xc34a9391c08b64c4a9167d9e1e884b3735ce21b0#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

TokenLogic receives no payment from Aave DAO or any external source for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).