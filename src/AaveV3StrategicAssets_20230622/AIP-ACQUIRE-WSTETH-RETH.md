---
title: Treasury Managemet - Acquire wstETH & rETH
discussions: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205/5
shortDescription: Convert 1,600 units of wETH/ETH held in the Collector Contract to 800 units of both wstETH and rETH.
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

**wstETH**

1. Deposit 104.548 ETH into stETH, wrap into wstETH and hold wstETH in Collector Contract
2. Redeem 695.452 awETH for ETH, deposit into stETH, wrap into wstETH and hold wstETH in Collector Contract.

**rETH**

1. Redeem 800.00 awETH for ETH, deposit into rETH and hold rETH in Collector Contract

# Implementation

A list of relevant links like for this proposal:

- [Test Cases]())
- [Payload Implementation]()

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
