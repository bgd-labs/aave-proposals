---
title: Update Mai Token implementations, unpause & enable flashloanable
author: BGD Labs
discussions: https://governance.aave.com/t/arfc-add-mai-to-arbitrum-aave-v3-market/12759/8
---

## Simple Summary

This proposal updates the `MAI` a/s/v token implementations on `Optimism` and `Arbitrum` to be aligned with `Aave 3.0.2`.
It also unpauses the `MAI` reserve and sets it as flashloanable.

## Motivation

In `Aave v3.0.2` the signature of `handleRepayment()` has changed and a `flashloanable` flag was added.
While all existing reserves `a/s/v` token implementations were upgraded in the [original proposal](https://app.aave.com/governance/proposal/213/) and flashloanable was set to `true` on all reserves, shortly after, `MAI` was listed on the `Optimism` and `Arbitrum` pools using the old implementations and not setting flashloanable to `true`.

In the current state repayments of MAI could still work, as `repayWithAToken` is not affected, but `liquidations` wouldn't work as they rely on `repay`.
To reduce risk, the Aave Guardian coordinated a pause for these mostly empty reserves (~$8'000 between Arbitrum and Optimism).

This proposal resolves the current issues by:

- Upgrading the `a/s/v` token implementations.
- Setting the `flashloanable` flashloanable flag to `true`.
- Unpausing the reserve.

## Specification

In order to align `MAI` with other tokens. The proposal executes the following commands:

- `POOL_CONFIGURATOR.updateAToken`
- `POOL_CONFIGURATOR.updateStableDebtToken`
- `POOL_CONFIGURATOR.updateVariableDebtToken`
- `POOL_CONFIGURATOR.setReservePause(AaveV3ArbitrumAssets.MAI_UNDERLYING, false)`
- `POOL_CONFIGURATOR.setReserveFlashLoaning(AaveV3ArbitrumAssets.MAI_UNDERLYING, true)`

## References

- [Discussion](https://governance.aave.com/t/arfc-add-mai-to-arbitrum-aave-v3-market/12759/8)
- [Code:ArbPayload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPARBMAIFixes_20230606/AaveV3ARBMAIFixes_20230606.sol)
- [Code:ArbTest](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPARBMAIFixes_20230606/AaveV3ARBMAIFixes_20230606_Test.t.sol)
- [Code:OptPayload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPARBMAIFixes_20230606/AaveV3OPMAIFixes_20230606.sol)
- [Code:OptTest](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3OPARBMAIFixes_20230606/AaveV3OPMAIFixes_20230606_Test.t.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
