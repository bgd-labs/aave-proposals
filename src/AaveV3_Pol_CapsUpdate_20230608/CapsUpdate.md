---
title: "[ARFC] Increase MaticX supply cap"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-increase-maticx-supply-cap/14341"
---

## Simple Summary

This proposal seeks to increase the supply cap for the MaticX token from 50.60M units to 62M units as:
    - Supply cap utilization reached 88%
    - The MaticX supply increased since the last AIP on the subject
    - LSD yields leveraging is one of the main sources of revenue for the DAO
    - An incentive program is currently taking place regarding the above strategy
If this proposal gets the green light from at least one service provider it will continue following the Direct-to-AIP framework.
## Motivation

The supply caps utilization climbed to 88% recently only a few days after the [last increase](https://app.aave.com/governance/proposal/278/).
Historically supply caps for LSD tokens have quickly been filled up, leading to the implementation of the direct-to-AIP framework, but still, proactivity from the DAO is needed for the smooth experience of the users. Since the total supply of MaticX increased since AIP-278, it is possible to increase the supply cap up to 62M while remaining below [75%](https://snapshot.org/#/aave.eth/proposal/0xf9261916c696ce2d793af41b7fe556896ed1ff7a8330b7d0489d5567ebefe3ba) of the total supply.

Currently, the DAO reserve is increasing by ~870 Matic a day thanks to users borrowing Matic, a sizable portion of them are doing so with MaticX token, increasing the MaticX cap would increase the demand for this asset and potentially attract more liquidity for it.

Last but not least, an [incentive program](https://governance.aave.com/t/arfc-stmatic-maticx-emission-admin-for-polygon-v3-liquidity-pool/10632) by the Polygon Foundation is currently running its course on Polygon V3 market, promoting the use of LSD yield leveraging with the MaticX tokens. Thus, this increase would also enhance the synergy with the rest of the ecosystem that is being built around this farming strategy.

## Specification

The following parameters would be modified for the [MaticX](https://polygonscan.com/token/0xfa68fb4628dff1028cfec22b4162fccd0d45efb6) token on the polygon V3 market:

| Parameters | Current  | Proposed | Increase |
| --- | --- | --- | --- |
| Supply Cap | 50.60M | 62M | ~22.5% |

This would be a bit less than 75% of the current total supply (83.31M)

## References

- Implementation: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Pol_CapsUpdate_20230608/AaveV3_Pol_CapsUpdate_20230608.sol)
- Tests: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Pol_CapsUpdate_20230608/AaveV3_Pol_CapsUpdate_20230608.t.sol)
- [Snapshot] No snapshot for Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-increase-maticx-supply-cap/14341)

# Disclaimer:

This proposal is powered by Skyward.
The author doesn’t possess MaticX tokens at the time of writing and isn’t paid by the Polygon foundation for this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
