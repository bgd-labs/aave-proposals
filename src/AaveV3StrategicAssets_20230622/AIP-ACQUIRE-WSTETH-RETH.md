---
title: Treasury Managemet - Acquire wstETH & rETH
discussions: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205/5
shortDescription: Convert 1,600 units of awETH/aEthWETH/ETH held in the Collector Contract to the equivalent of 800 units of both wstETH and rETH.
author: Llama (Fermin Carranza & TokenLogic)
created: 2023-06-23
---

# Summary

This AIP will convert 1,600 wETH to equal amounts of wstETH and rETH to be held in the Ethereum Collector Contract.

# Motivation

Aave DAO currently holds 1,786.51 awETH (v2) and 104.548 units of ETH in the Collector Contract. The awETH deposit yield in Aave v2 earns 1.69%, relative to 3.8% with wstETH and 3.13% with rETH.

This AIP converts all the unproductive ETH balance and 695.452 units of wETH into wstETH. The total wstETH acquired will be 800 units.

800.00 units of awETH will be converted to rETH.

# Specification

The following provides an overview for how the wstETH and rETH is acquired.

1. Withdraw 1,400 units of awETH into wETH.
2. Withdraw 200 untis of aEthWeth into wETH.
3. Withdraw 104.548 units of ETH.
4. Deposit into RocketPool 800 ETH.
5. Deposit into Lido's stETH 800 ETH.
6. Wrap the received stETH into wstETH.

# Implementation

A list of relevant links like for this proposal:

- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3StrategicAssets_20230622/AaveV3StrategicAssets_20220622PayloadTest.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3StrategicAssets_20230622/AaveV3StrategicAssets_20220622Payload.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
