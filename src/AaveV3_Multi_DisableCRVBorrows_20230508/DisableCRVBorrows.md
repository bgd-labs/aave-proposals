---
title: Disable CRV Borrowing For Ethereum and Polygon V3
author: Omer Goldberg (@omeragoldberg - Chaos Labs)
discussions: https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/42
---

## Simple Summary

An AIP to disable borrowing of CRV on Ethereum and Polygon V3.

## Motivation

We'd like to disable the ability to short CRV via the Aave protocol.

## Specification

Ticker: CRV

Contract Address Ethereum: [0xD533a949740bb3306d119CC777fa900bA034cd52](https://etherscan.io/address/0xD533a949740bb3306d119CC777fa900bA034cd52)`

Contract Address Polygon: [0x172370d5Cd63279eFa6d502DAB29171933a610AF](https://etherscan.io/address/0x172370d5Cd63279eFa6d502DAB29171933a610AF)`

### new Risk Parameters

| Parameter         | Value    |
| :---------------- | :------- |
| Enabled to Borrow | DISABLED |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Eth_DisableCRVBorrows_20230508.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Pol_DisableCRVBorrows_20230508.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Eth_DisableCRVBorrows_20230508.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_DisableCRVBorrows_20230508/AaveV3_Pol_DisableCRVBorrows_20230508.t.sol)
- [Discussion](https://governance.aave.com/t/post-vyper-exploit-crv-market-update-and-recommendations/14214/42)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
