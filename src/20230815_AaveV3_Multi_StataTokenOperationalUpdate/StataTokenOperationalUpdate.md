---
title: "stataToken operational update"
author: "BGD labs"
discussions: "https://governance.aave.com/t/bgd-statatoken-operational-update/14497"
---

## Simple Summary

Transfer of the ownership of the stataToken helper contracts used exclusively by Balancer to their governance, in order for them to execute efficient and time-synced implementations upgrades.

## Motivation

The Balancer team approached us regarding potential improvements:

Change the underlying asset to be underlying on Aave instead of aToken (e.g. USDC instead of aUSDC).
Improvement in the management of incentives on Aave v3.
However, as the stataTokens are currently Aave governance-controlled and multi-chain, both this operational effort and the (required) time synchronizing across networks becomes complicated, as proposals execute at different times (Ethereum ~5 days, all other networks ~7 days).

For that reason, and given that currently these non-core (helper) contracts are almost exclusively used by Balancer, we think the best solution is to transfer the ownership of these stataTokens to the Balancer governance and have them execute a sync upgrade.

## Specification

The proposal calls `changeProxyAdmin(proxy, newAdmin)` on the respective token, moving the permissions from the current proxyAdmin to the Balancer DAO on the respective network:

- [Ethereum](https://etherscan.io/address/0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f)
- [Polygon](https://polygonscan.com/address/0xeE071f4B516F69a1603dA393CdE8e76C40E5Be85)
- [Arbitrum](https://arbiscan.io/address/0xaF23DC5983230E9eEAf93280e312e57539D098D0)
- [Optimism](https://optimistic.etherscan.io/address/0x043f9687842771b3dF8852c1E9801DCAeED3f6bc)
- [Avalanche](https://snowtrace.io/address/0x17b11FF13e2d7bAb2648182dFD1f1cfa0E4C7cf3)

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Ethereum_StataTokenOperationalUpdate_20230815.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Optimism_StataTokenOperationalUpdate_20230815.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Polygon_StataTokenOperationalUpdate_20230815.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Avalanche_StataTokenOperationalUpdate_20230815.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Ethereum_StataTokenOperationalUpdate_20230815.t.sol), [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Optimism_StataTokenOperationalUpdate_20230815.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Arbitrum_StataTokenOperationalUpdate_20230815.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Polygon_StataTokenOperationalUpdate_20230815.t.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230815_AaveV3_Multi_StataTokenOperationalUpdate/AaveV3_Avalanche_StataTokenOperationalUpdate_20230815.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-statatoken-operational-update/14497)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
