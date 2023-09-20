---
title: Treasury Management - Avalanche v2 to v3 Migration
discussions: https://governance.aave.com/t/arfc-treasury-management-avalanche-v2-to-v3-migration/14469
author: TokenLogic
---

# Summary

Redeem the Aave DAO funds on Aave v2 Avalanche and deposit underlying assets in Aave v3 Avalanche.

# Motivation

Aave DAO currently holds around $4.52M on Avalanche v2. There are several drivers for migrating Aave DAO's funds:

* Higher deposit rates
* wAVAX incentives
* Encourage migration v2 to v3

Most of these funds can be migrated to v3 with the exception of USDT. There is not enough liquidity to redeem the entire 541.51K of USDT. As a result, approximately 25% of the USDT will be redeemed and deposited into v3.

# Specification

Migrate the following holdings:

| Asset | Migrate (%) |
| --- | --- |
|wBTC.e|100|
|wETH.e|100|
|DAI.e|100|
|AVAX.e|100|

Deposit wAVAX held passively in the Treasury into Aave v3.

For reference, the Aave Avalanche v2 Treasury: [`0x5ba7fd868c40c16f7aDfAe6CF87121E13FC2F7a0`](https://snowtrace.io/address/0x5ba7fd868c40c16f7aDfAe6CF87121E13FC2F7a0)

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-treasury-management-avalanche-v2-to-v3-migration/14469)
* [Snapshot vote](https://snapshot.org/#/aave.eth/proposal/0x0be8229173181fe0aaf5ed1883e53752546efb810e55610e7ac8b991155ab788)
* [Test Cases](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveAvalancheTreasuryMigration_20230903/AaveAvalancheTreasuryMigration_20230903.t.sol)
* [Payload Implementation](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveAvalancheTreasuryMigration_20230903/AaveAvalancheTreasuryMigration_20230903.sol)
* [Deployed Contracts](TODO)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

TokenLogic receives no payment from Aave DAO or any external source for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).