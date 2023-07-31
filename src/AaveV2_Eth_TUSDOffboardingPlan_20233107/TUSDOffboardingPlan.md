---
title: TUSD offboarding plan
author: Marc Zeller (@marczeller - Aave Chan Initiative), Gauntlet
discussions: https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008
---

## Simple Summary

This proposal aims to initiate the offboarding process for TUSD from the Aave V2 Ethereum pool. The process will follow a similar process as the [BUSD offboarding plan part I](https://governance.aave.com/t/arfc-busd-offboarding-plan/12170).

## Motivation

TUSD has been a historic asset of the Aave ecosystem, but due to recent events, the ACI suggests consideration of its offboarding. The offboarding plan leverages the previous success of the BUSD offboarding plan and will incentive current users to slowly migrate their positions to other stablecoins on Aave.


Previous proposals have [frozen TUSD](https://app.aave.com/governance/proposal/253/) and [lowered TUSD LT to 77.5%. ](https://app.aave.com/governance/proposal/256/) These proposals have reduced TUSD borrow and supply over the past 30 days, from 20M supplied and 18M borrowed, to 13.1M supplied and 6.8M borrowed today.

## Specification

The following table outlines the proposed changes to the TUSD risk parameters:

| Parameter                | Current Value | Proposed Value |
|--------------------------|---------------|----------------|
| LTV                      | 75%           | 0%             |
| Liquidation Threshold    | 80%           | 75%            |
| Liquidation Bonus        | 5%            | 10%            |
| Reserve Factor           | 25%           | 95%            |
| Borrowing Enabled        | Yes           | No             |
| Stable Borrowing Enabled | Yes           | No             |
| Base Rate                | 0%            | 3%             |
| Slope1                   | 4%            | 7%             |
| Slope2                   | 100%          | 200%           |
| UOptimal                 | 80%           | 20%            |


## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_TUSDOffboardingPlan_20233107/AaveV2_Eth_TUSDOffboardingPlan_20233107.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2_Eth_TUSDOffboardingPlan_20233107/AaveV2_Eth_TUSDOffboardingPlan_20233107.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xfd0cdbf58992759f47e6f5a6c07cbeb2b1a02af1c9ebf7d3099b80c33f53c138)
- [Discussion](https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
