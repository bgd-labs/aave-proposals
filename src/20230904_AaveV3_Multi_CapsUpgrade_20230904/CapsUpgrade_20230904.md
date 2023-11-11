---
title: "CapsUpgrade_20230904"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-aave-v3-caps-increase-2023-08-31/14698"
---

## Simple Summary

This proposal is asking for feedback from the risk providers on various assets across multiple networks that are nearing the full use of either their supply or borrow caps.

This Proposal is compatible with the Direct-to-AIP Framework

## Motivation

Several caps on assets across the various V3 markets are reaching critical levels but haven’t been included in [the recent proposal by ChaosLabs](https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-increase-borrow-caps-on-v3-ethereum-08-29-2023/14688). Thus, the goal of this proposal is to ask about their status and the risk associated with the potential increase of their caps. Letting those caps reach 100% while it could have been avoided would result in a sub-optimal experience for the user of AAVE and of the product built around the protocol as well as a loss of potential revenue.

## Specification

The following assets are concerned by the proposal

### Supply Caps:

| Chain | Token | Supply cap | Utilization rate | Proposed Supply cap | Increase (%) | Total supply | % of the total supply |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Arbitrum | AAVE | 1.85k | 100% | 2710 | 46% | 5.4k | ~50% |
| Metis | Metis | 60k | 76% | 120k | 100% | 2.96M | 4% |
| Polygon | DPI | 1.417 | 87% | 2460 | ~73% | 4928 | ~50% |

## References

- Implementation: [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Arbitrum_CapsUpgrade_20230904_20230904.sol), [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Metis_CapsUpgrade_20230904_20230904.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Polygon_CapsUpgrade_20230904_20230904.sol)
- Tests: [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Arbitrum_CapsUpgrade_20230904_20230904.t.sol), [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Metis_CapsUpgrade_20230904_20230904.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Multi_CapsUpgrade_20230904/AaveV3_Polygon_CapsUpgrade_20230904_20230904.t.sol)
- Snapshot: no snapshot for Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-caps-increase-2023-08-31/14698)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
