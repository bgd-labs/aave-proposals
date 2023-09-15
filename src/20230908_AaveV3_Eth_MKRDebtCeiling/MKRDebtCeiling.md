---
title: "Aave V3 Ethereum MKR Debt Ceiling Update"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-borrowing-cap-expansion-request-mkr/14763"
---

## Simple Summary

This is a proposal to expand the current cap of borrowing against an isolated collateral (MKR) from $2.5 million to $6.0 million.
This proposal is compatible with Direct-to-AIP.

## Motivation

Organic demand to use the MKR asset has reached the currently set ceiling.
To accommodate this demand and in alignment with Risk service providers teams recommendation, this AIP proposes to expand the MKR debt ceiling from 2.5M$ to 6M$

## Specification

The following parameter will be modified:

| Token           | Current debt ceiling | Proposed debt ceiling |
| --------------- | -------------------- | --------------------- |
| MKR Ethereum V3 | 2.5M$                | 6M$                   |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230908_AaveV3_Eth_MKRDebtCeiling/AaveV3_Ethereum_MKRDebtCeiling_20230908.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230908_AaveV3_Eth_MKRDebtCeiling/AaveV3_Ethereum_MKRDebtCeiling_20230908.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-borrowing-cap-expansion-request-mkr/14763)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
