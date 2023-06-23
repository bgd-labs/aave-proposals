---
title: Treasury Managemet - Acquire wstETH & rETH
discussions: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205/5
author: Llama (Fermin Carranza & TokenLogic)
---

# Summary

This AIP will convert 1,600 ETH to equal amounts of wstETH and rETH to be held in the Ethereum Collector Contract.

# Motivation

Aave DAO currently holds 1,786.51 awETH (v2) and 104.548 units of ETH in the Collector Contract. The awETH deposit yield in Aave v2 earns 1.69%, relative to 3.8% with wstETH and 3.13% with rETH.

This AIP converts all the unproductive ETH balance, along with aWETH (v2 and v3) into the same amounts of wstETH and rETH.

# Specification

The following provides an overview for how the wstETH and rETH is acquired.

1. Withdraw 1,400 units of awETH (Aave V2 wETH) into ETH.
2. Withdraw all the raw ETH (~104 units) from the collector.
3. Withdraw the margin (~96 units) of aEthWETH (Aave V3 wETH) into ETH.
4. Deposit into RocketPool 800 ETH.
5. Deposit into Lido's stETH 800 ETH.
6. Wrap the received stETH into wstETH.
7. Transfer wstETH and rETH into collector.

# Implementation

A list of relevant links like for this proposal:

- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3StrategicAssets_20230622/AaveV3StrategicAssets_20220622PayloadTest.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3StrategicAssets_20230622/AaveV3StrategicAssets_20220622Payload.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
