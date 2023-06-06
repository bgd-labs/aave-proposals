---
title: Update Mai Token implementations, unpause & enable flashloaning
author: BGD Labs
discussions: https://governance.aave.com/t/arfc-add-mai-to-arbitrum-aave-v3-market/12759/8
---

## Simple Summary

This proposal updates the `MAI` a/s/v token implementations on `optimism` and `arbitrum` to be aligned with `Aave 3.0.2`.
It also unpauses the `MAI` reserve and enables flashloans.

## Motivation

In `Aave v3.0.2` the signature of `repay` has changed and a `flashloanable` flag was added.
While all existing reserves `a/s/v` implementations were upgraded in the [original proposal](https://app.aave.com/governance/proposal/213/) and flashloanable was set to `true` on all reserves, shortly after `MAI` was listed on `optimism` and `arbitrum` pools using the old implementations and not setting flashloanable to `true`.

In the current state repayments could still work, as `repayWithAToken` is not affected, but `liquidations` wouldn't work as they rely on `repay`.
To reduce risk, the guardian coordinated a pause for these mostly empty reserves(~8k).

This proposal resolves the current issues & unpauses the reserve by:

- upgrading the `a/s/v` token implementations
- setting `flashloanable` to `true`
- unpausing the pool

## Specification

In order to align `MAI` with other tokens. The proposal executes the following commands.

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
