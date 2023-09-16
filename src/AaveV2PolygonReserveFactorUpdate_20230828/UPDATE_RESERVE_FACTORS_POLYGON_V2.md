---
title: Reserve Factor Updates - Polygon Aave v2
author: TokenLogic
discussions: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/6
---

# Simple Summary

This AIP is a continuation of [AIP 284](https://app.aave.com/governance/proposal/284/) and increases the Reserve Factor (RF) for assets on Polygon v2 by 5%, up to a maximum of 99.99%.

# Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged. 

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by 5%.

The next AIP will be submitted during the first week of October.

# Specification

The following parameters are to be updated as follows:

|Asset|Reserve Factor|
|---|---|
|DAI|31.00%|
|USDC|33.00%|
|USDT|32.00%|
|wBTC|65.00%|
|wETH|55.00%|
|MATIC|51.00%|
|BAL|42.00%|

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/6)

* [Test Cases](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveV2PolygonReserveFactorUpdate_20230717/AaveV2PolygonReserveFactorUpdate_20230717.t.sol)

* [Payload Implementation](https://github.com/bgd-labs/aave-proposals/tree/main/src/AaveV2PolygonReserveFactorUpdate_20230717/AaveV2PolygonReserveFactorUpdate_20230717.sol)

* [Pre-Post Payload Protocol Diff](https://github.com/bgd-labs/aave-proposals/tree/main/diffs/preTestPolygonReserveFactorUpdate20230828_postTestPolygonReserveFactorUpdate20230828.md)

* [Deployed Contracts](https://polygonscan.com/address/0x40fa5610f17a99d20bd428810bec965fe4694238#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

The author, TokenLogic, receives no payment from anyone, including Aave DAO, for this proposal. TokenLogic is a delegate within the Aave community. 

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).