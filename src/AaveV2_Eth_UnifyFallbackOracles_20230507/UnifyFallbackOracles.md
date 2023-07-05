---
title: Prices operational update. Unify disabled fallback oracles
author: BGD Labs (@bgdlabs)
discussions:
---

## Simple Summary

Unify the approach of Aave v1 and Aave v2 fallback oracles with Aave v3: fully disabling it by pointing to address(0), until (if) the community decides to explicitly re-activating them.

## Motivation

The fallback oracle is a legacy mechanism, currently deprecated, as reliance on the main oracle (Chainlink) is expected, so there is not really much value on fallback.
Even if currently the community is exploring re-activating the fallback in Aave v3 Optimism, before that, the fallback should be configured on all Aave instances to the null address (address(0)), to be technically fully consistent.
More specifically, this will affect Aave v1 and all the Aave v2 instances on which there is any inactive fallback connected.

## Specification

- call `ORACLE.setFallbackOracle(address(0))` to replace the fallback oracle with the null address on Aave v1, Aave v2 and Aave v2 AMM

## References

- Implementation: [Ethereum](src/AaveV2_Eth_RemoveFallbackOracles_20230407/AaveV2EthRemoveFallbackOracles20230407.sol)
- Tests: [Ethereum](src/AaveV2_Eth_RemoveFallbackOracles_20230407/AaveV2EthRemoveFallbackOracles20230407.t.sol)
- [Snapshot]()
- [Discussion]()

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
