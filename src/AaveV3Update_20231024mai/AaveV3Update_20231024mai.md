---
title: Gauntlet Recommendation for MAI/MIMATIC deprecation, 2023.10.23
author: Gauntlet
discussions: https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation/15119
---

## Summary

Given MAI/MIMATIC price drop to ~$0.72 and its inability to regain peg for the past few months, Gauntlet recommends to begin deprecation of MAI/MIMATIC. We aim to do so by reducing LT and increasing borrow rates to incentivize repayment.

## Specification

#### LT reductions

| Chain        | Asset       | Current LT | Recommended LT |
| ------------ | ----------- | ---------- | -------------- |
| avalanche v3 | MAI/MIMATIC | 0.8        | 0              |
| arbitrum v3  | MAI/MIMATIC | 0.8        | 0              |
| polygon v3   | MAI/MIMATIC | 0.8        | 0              |
| optimism v3  | MAI/MIMATIC | 0.8        | 0.65           |

#### IR recommendations

Adjust Uopt to 0.45, Slope 2 to 300%, RF to 95%

| Chain        | Asset   | Current Uopt | Current Slope2 | Current RF | Recommended Uopt | Recommended Slope2 | Recommended RF |
| ------------ | ------- | ------------ | -------------- | ---------- | ---------------- | ------------------ | -------------- |
| arbitrum v3  | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| avalanche v3 | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| optimism v3  | MAI     | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |
| polygon v3   | miMATIC | 0.8          | 0.75           | 0.2        | 0.45             | 3                  | 0.95           |

## Implementation

The proposal implements changes using the following payloads:

- [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231024mai/AaveV3Arbitrum_20231024mai.sol)
- [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231024mai/AaveV3Optimism_20231024mai.sol)
- [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231024mai/AaveV3Polygon_20231024mai.sol)

The changes on avalanche can be implemented using the following steward:

- [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231024mai/AaveV3Avalanche_20231024mai.sol)

## References

- **Discussion**: https://governance.aave.com/t/arfc-gauntlet-recommendation-for-mai-mimatic-deprecation/15119

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
