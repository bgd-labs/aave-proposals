---
title: "GHO update on Aave V3 Ethereum Pool"
author: "Aave Companies @AaveAave"
discussions: "https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626"
---

## Simple Summary

This proposal fixes a technical issue in the GHO integration with the Aave V3 Pool, making the reactivation of the facilitator possible.

Additionally, a borrowing limit of 35 million GHO has been introduced to help manage risk exposure effectively. In this way, the borrow cap can be adjusted by the RiskSteward based on the existing framework for agile changes on caps.

## Motivation

A resolution for the identified technical issue in the GHO integration with the Aave V3 Ethereum Pool is presented. This fix guarantees a seamless reactivation of the facilitator while upholding the utmost safety standards.

## Specification

The proposal payload does the following:

1. Upgrade the implementation of GhoVariableDebtToken.
2. Set a borrow cap of 35M to GHO asset on Aave V3 Ethereum Pool.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230826_AaveV3_Eth_VGHOImprovement/AaveV3_Ethereum_VGHOImprovement_20230826.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230826_AaveV3_Eth_VGHOImprovement/AaveV3_Ethereum_VGHOImprovement_20230826.t.sol)
- [Discussion](https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
