---
title: "Enable borrow of OP token"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633"
---

## Simple Summary

This proposal updates the OP lending pool to make it reflect the change voted in AIP-337.

## Motivation

While a [previous AIP](https://app.aave.com/governance/proposal/337/) updated the parameters of the Aave V3 Optimism pool for the OP asset, it didn't enable the borrow of the Optimism token. Thus this AIP proposes to deliver the second part of the AIP-337 by enabling borrowing of OP tokens matching it's original intent.

## Specification

- **Asset**: OP
- **OP Contract Address**: [0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042)

**New Risk Parameters**:

| Parameter         | Value   |
| ----------------- | ------- |
| Asset             | OP      |
| Enabled to Borrow | Enabled |

As a reminder, here are the previously updated parameters:

| Parameter                      | Value    |
| ------------------------------ | -------- |
| Asset                          | OP       |
| Supply Cap                     | 10M      |
| Borrow Cap                     | 500k     |
| Loan To Value (LTV)            | 30%      |
| Liquidation Threshold (LT)     | 40%      |
| Liquidation Penalty (LP)       | 10%      |
| Liquidation Protocol Fee (LPF) | 10%      |
| Stable Borrow                  | Disabled |
| Base Variable Rate             | 0%       |
| Slope1                         | 7%       |
| Slope2                         | 300%     |
| Optimal Ratio                  | 45%      |
| Reserve Factor (RF)            | 20%      |

## References

- Implementation: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/97699d8b552b7b3d32e58393d1721ed0f9152368/src/20231016_AaveV3_Opt_EnableBorrowOfOPToken/AaveV3_Optimism_EnableBorrowOfOPToken_20231016.sol)
- Tests: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/97699d8b552b7b3d32e58393d1721ed0f9152368/src/20231016_AaveV3_Opt_EnableBorrowOfOPToken/AaveV3_Optimism_EnableBorrowOfOPToken_20231016.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x617adb838ce95e319f06f72e177ad62cd743c2fe3fd50d6340dfc8606fbdd0b3)
- [Discussion](https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
