---
title: Optimism - Create ETH eMode Category
discussions: https://governance.aave.com/t/arfc-optimism-create-eth-e-mode/13144
author: Llama, TokenLogic
---

# Summary

This AIP if implemented will create an ETH nominated eMode category on the Aave v3 Optimism deployment.

# Motivation

Creation of an eMode on Aave v3 Optimism will enable users to enter yield maximising strategies with greater capital efficiency.

With the introduction of an ETH eMode, Aave Protocol is expected to experience greater borrowing demand for wETH, leading to enhanced revenue generation.

The introduction of the ETH eMode is expected to lead to structured yield maximising products/strategies being built on Aave Protocol.

wstETH and wETH will be included as initial assets within the ETH correlated eMode.

# Specification

The following risk parameters have been approved by Chaos Labs.

Ticker: wstETH

Contract: [`optimism:0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb`](https://optimistic.etherscan.io/token/0x1f32b1c2345538c0c6f582fcb022739c4a194ebb)

Ticker: wETH

Contract: [`optimism:0x4200000000000000000000000000000000000006`](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006)

| Parameter             | Value              |
| --------------------- | ------------------ |
| Category              | 1 (ETH Correlated) |
| Assets                | wstETH, wETH       |
| Loan to Value         | 90.00%             |
| Liquidation Threshold | 93.00%             |
| Liquidation Bonus     | 1.00%              |

# Implementation

A list of relevant links for this proposal:

- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPEmode_20220622/AaveV3OPEmode_20220622_PayloadTest.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPEmode_20220622/AaveV3OPEmode_20220622_Payload.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
