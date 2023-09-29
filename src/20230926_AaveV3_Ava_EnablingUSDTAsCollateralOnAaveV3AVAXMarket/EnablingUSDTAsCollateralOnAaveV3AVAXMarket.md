---
title: "Enabling USDT as collateral on Aave v3 AVAX Market"
author: "Marc Zeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-enabling-usdt-as-collateral-on-aave-v3-avax-market/14632/3"
---

## Simple Summary

This proposal seeks to enable USDT as collateral on the V3 AVAX market outside of isolation mode as well as update the risk parameters to be on par with USDC.

## Motivation

Enabling USDT as a normal collateral with those updated parameters would incentivize the use of USDT to borrow other assets on the v3 AVAX market. This would increase protocol revenue as well as the attractiveness of the platform for lenders. This change would be aligned with other changes started to increase USDT utility across the various Aave markets.

## Specification

The following table highlights the proposed change for USDT on the v3 AVAX market (as well as those for USDC for reference):

| Parameters | USDT (current) | USDT (proposed) | USDC (for reference) |
| --- | --- | --- | --- |
| Supply Cap | 200M | 100M | 170M |
| Borrow Cap | 140M | 80M | 90M |
| LTV | 75% | 75.0% | 82.25% |
| LT | 81% | 81.0% | 86.25% |
| LB | 5% | 5% | 4% |
| Isolation Mode | Yes | No | No |
| Debt ceiling | 5M | N/A | N/A |

## References

- Implementation: [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Ava_EnablingUSDTAsCollateralOnAaveV3AVAXMarket/AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.sol)
- Tests: [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230926_AaveV3_Ava_EnablingUSDTAsCollateralOnAaveV3AVAXMarket/AaveV3_Avalanche_EnablingUSDTAsCollateralOnAaveV3AVAXMarket_20230926.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x5623b5f84f021ad787033b4a1efd9e2de417004d27c5f2e3d7351f9b575574b1)
- [Discussion](https://governance.aave.com/t/arfc-enabling-usdt-as-collateral-on-aave-v3-avax-market/14632/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
