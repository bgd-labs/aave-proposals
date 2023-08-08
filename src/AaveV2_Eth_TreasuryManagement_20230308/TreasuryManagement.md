---
title: Swap assets to aUSDC
author: Llama
discussions: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
---

## Simple Summary

The purpose of this proposal is to hold sufficient runway in v2 USDC and begin deploying a portion of the funds held in the Ethereum Collector Contract to earn yield.

## Motivation

This publication presents a proposal for Aave to deploy its Ethereum Collector Contract holdings to earn yield.

There are a number of Service Providers requiring payment in aUSDC. In order to provide sufficient funding, assets need to be converted to aUSDC. This publication proposes swapping assets to USDC and then depositing the USDC into Aave v2. The amount of aUSDC held post swap will be sufficient to sustain the DAO in the short term. We plan to do a follow up proposal to ensure the DAO has sufficient aUSDC runway.

## Specification

Withdraw the following aTokens:

MKR
GUSD
FRAX
UST
LUSD
YFI
UNI
TUSD
RWA USDC

Once withdrawn, swap the listed assets above plus:

USDT
DAI

Swap for USDC via COW Swap.

Once USDC is acquired, deposit into Aave V2 for aUSDC.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_TreasuryManagement_20230308/AaveV2_Eth_TreasuryManagement_20230308.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_TreasuryManagement_20230308/AaveV2_Eth_TreasuryManagement_20230308.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083)
- [Discussion](https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
