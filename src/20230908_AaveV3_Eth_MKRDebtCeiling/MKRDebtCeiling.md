---
title: "MKRDebtCeiling"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-borrowing-cap-expansion-request-mkr/14763"
---

## Simple Summary

This is a proposal to expand the current cap of borrowing against an isolated collateral (MKR) from $2.5 million to $6.0 million.
This proposal is compatible with Direct-to-AIP.

## Motivation

The Aave user @Leritu wishes to borrow more asset with his $6.4 million in MKR but the Debt Ceiling has been reached. 

## Specification
The following parameter will be modified:

| Token | Current debt ceiling | Proposed debt ceiling |
| --- | --- | --- |
| MKR Ethereum V3 | 2.5M$ | 6M$ |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230908_AaveV3_Eth_MKRDebtCeiling/AaveV3_Ethereum_MKRDebtCeiling_20230908.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230908_AaveV3_Eth_MKRDebtCeiling/AaveV3_Ethereum_MKRDebtCeiling_20230908.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-borrowing-cap-expansion-request-mkr/14763)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
