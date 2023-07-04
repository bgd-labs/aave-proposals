---
title: Chaos Labs - Increase wstETH Supply Cap on V3 Arbitrum
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-increase-caps-reth-and-wsteth-on-v3-arbitrum/13817
author: ChaosLabsInc (@yonikesel, @ori-chaoslabs)
---

# Summary

A proposal to increase the Supply cap for wstETH on V3 Arbitrum.

# Motivation

The supply and borrow cap for wstETH on V3 Arbitrum is currently at 100% utilization.
Utilizing our [supply cap methodology](https://governance.aave.com/t/chaos-labs-supply-cap-methodology/12842), we conducted stress tests simulating depeg scenarios (up to 15%). Given an increase of the supply cap to 30K, such a depeg scenario materializing could lead to protocol losses of ~$500K. This is an extreme scenario, given the Oracle configuration update introduced [here](https://app.aave.com/governance/proposal/248/).

# Specification

Ticker: wstETH (wstETH)

Contract Address: [0x5979D7b546E38E414F7E9822514be443A4800529](https://arbiscan.io/address/0x5979d7b546e38e414f7e9822514be443a4800529)

| Chain    | Asset  | Current Supply Cap | Recommended Supply Cap | Current Borrow Cap | Recommended Borrow Cap |
| -------- | ------ | ------------------ | ---------------------- | ------------------ | ---------------------- |
| Arbitrum | wstETH | 18,750             | 30,000                 | 800                | No Change              |

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ArbwstETHCapsUpdates_20230703/AaveV3ArbwstETHCapsUpdates_20230703Test.t.sol)
- [Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ArbwstETHCapsUpdates_20230703/AaveV3ArbwstETHCapsUpdates_20230703.sol)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
