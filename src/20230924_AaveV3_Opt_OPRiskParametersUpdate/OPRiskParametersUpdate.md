---
title: "OP Risk Parameters Update"
author: "Marc Zeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633"
---

## Simple Summary

This AIP proposes the activation of OP as a borrowable asset in the Aave V3 Optimism pool. The aim is to adapt to the maturity of the L2 and attract more suppliers and borrowers, thereby generating new revenue for the protocol.

## Motivation

The Aave OP V3 market is one of the Aave V3 L2 deployments, with OP being the native asset of the OP L2. At its inception, the L2 was in its early stages, leading to the onboarding of OP with conservative parameters due to nascent liquidity & infrastructure.

As the L2 has matured, the ACI proposes less conservative parameters for the OP asset. By removing the isolation mode for OP and allowing its borrowing, we anticipate attracting more suppliers who can earn a yield on their OP deposits and new borrowers who can use OP to borrow additional assets. This will also generate new revenue for the protocol.

While the proposed changes are less conservative, they still maintain strict supply, borrow caps, and a conservative interest rate strategy. This ensures that the DAO promotes growth and new opportunities while remaining risk-averse. Based on the collected market data post-implementation, the community will have the opportunity to revisit these parameters at a later stage.

## Specification

- **Asset**: OP
- **OP Contract Address**: [0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042)

**New Risk Parameters**:

| Parameter | Value |
| --- | --- |
| Asset | OP |
| Supply Cap | 10M |
| Borrow Cap | 500k |
| Loan To Value (LTV) | 30% |
| Liquidation Threshold (LT) | 40% |
| Liquidation Penalty (LP) | 10% |
| Liquidation Protocol Fee (LPF) | 10% |
| Stable Borrow | Disabled |
| Base Variable Rate | 0% |
| Slope1 | 7% |
| Slope2 | 300% |
| Optimal Ratio | 45% |
| Reserve Factor (RF) | 20% |

## References

- Implementation: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/4dffb1b7a544863fba61a573bc0b631ff6525bc7/src/20230924_AaveV3_Opt_OPRiskParametersUpdate/AaveV3_Optimism_OPRiskParametersUpdate_20230924.sol)
- Tests: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/4dffb1b7a544863fba61a573bc0b631ff6525bc7/src/20230924_AaveV3_Opt_OPRiskParametersUpdate/AaveV3_Optimism_OPRiskParametersUpdate_20230924.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x617adb838ce95e319f06f72e177ad62cd743c2fe3fd50d6340dfc8606fbdd0b3)
- [Discussion](https://governance.aave.com/t/arfc-op-risk-parameters-update-aave-v3-optimism-pool/14633)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
