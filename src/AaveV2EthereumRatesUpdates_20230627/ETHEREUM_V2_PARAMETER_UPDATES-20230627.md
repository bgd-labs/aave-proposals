---
title: Ethereum v2 - Parameters Update
author: ChaosLabsInc
discussions: https://governance.aave.com/t/arfc-chaos-labs-incremental-reserve-factor-updates-aave-v2-ethereum/13766
---

# Simple Summary

A proposal for a series of Reserve Factor (RF) increases across all V2 Ethereum assets.

# Motivation

In line with our [V2 to V3 migration plan](https://governance.aave.com/t/temp-check-ethereum-v2-to-v3-migration/12636), we propose a series of RF increases on Aave V2 Ethereum.

By progressively increasing the reserve factors, the interest rate for supplying these assets on V2 will be increasingly less attractive, thus encouraging suppliers to transition positions to V3.

This proposal intends to incrementally increase the reserve factors by 5% at each step. After implementing each increment, we’ll assess user elasticity and the impact of the updates before moving forward with additional increases. We will ensure a minimum gap of 2 weeks between each subsequent update.

Please note that a separate proposal will be made for frozen assets on V2.

# Specification

The following parameters are to be updated:

| Asset | Current RF | Recommended RF |
| ----- | ---------- | -------------- |
| DAI   | 10.00%     | 15.00%         |
| FRAX  | 20.00%     | 25.00%         |
| GUSD  | 10.00%     | 15.00%         |
| LUSD  | 10.00%     | 15.00%         |
| sUSD  | 20.00%     | 25.00%         |
| TUSD  | 5.00%      | 25.00%         |
| USDC  | 10.00%     | 15.00%         |
| USDP  | 10.00%     | 15.00%         |
| USDT  | 10.00%     | 15.00%         |
| 1INCH | 20.00%     | 25.00%         |
| CRV   | 20.00%     | 25.00%         |
| ENS   | 20.00%     | 25.00%         |
| LINK  | 20.00%     | 25.00%         |
| MKR   | 20.00%     | 25.00%         |
| SNX   | 35.00%     | 40.00%         |
| UNI   | 20.00%     | 25.00%         |
| wBTC  | 20.00%     | 25.00%         |
| ETH   | 15.00%     | 20.00%         |

# Implementation

A list of relevant links like for this proposal:

- [Test](https://github.com/defijesus/aave-proposals/blob/main//Users/yoni/repos/aave-proposals/src/AaveV2EthereumRatesUpdates_20230627/AaveV2EthereumRatesUpdates_20230627.t.sol)
- [Payload Implementation](https://github.com/defijesus/aave-proposals/blob/main//Users/yoni/repos/aave-proposals/src/AaveV2EthereumRatesUpdates_20230627/AaveV2EthereumRatesUpdates_20230627.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
