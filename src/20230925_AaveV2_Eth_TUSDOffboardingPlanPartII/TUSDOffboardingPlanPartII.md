---
title: "TUSD Offboarding Plan Part II"
author: "Marc Zeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-tusd-offboarding-plan-part-ii/14863"
---

## Simple Summary

This AIP proposes the continuation of the [TUSD offboarding plan](https://governance.aave.com/t/arfc-tusd-offboarding-plan/14008) from Aave V2 by adjusting its risk parameters, mirroring the approach taken in the "[ARFC] BUSD Offboarding Plan Part III".

## Motivation

This proposal is a continuation of stablecoins offboarding of the Aave V2 market.
TUSD is proposed to adopt the "final stage" offboarding parameters to incentivize repayment and withdrawal of liquidity in Aave V2 Pool

aBUSD will be withdrawn and converted to BUSD.

This ARFC also aims to authorize the ACI to publish regularly "withdraw aToken" mechanical AIPs that have low governance value. Part of the success of these offboarding plans relies on maintaining the available liquidity low, adding pressure on borrowers, and incentivizing repayment or, if there's a lack of reaction, accelerating HF decay to create liquidations.

## Specification

The risk parameters for TUSD on Aave V2 will be adjusted as follows:

| Parameter                  | Previous Value | New Value |
| -------------------------- | -------------- | --------- |
| Loan-to-Value (LTV)        | 0%             | 0%        |
| Liquidation Threshold (LT) | 75%            | 65%       |
| Liquidation Bonus          | 10%            | 10%       |
| Reserve Factor             | 95%            | 99.9%     |
| uOptimal                   | 20%            | 1%        |
| Base Rate                  | 0%             | 100%      |
| Slope 1                    | 10%            | 70%       |
| Slope 2                    | 200%           | 300%      |

Both aTUSD & aBUSD Aave treasury available treasury will be withdrawn from Aave V2 pool. this is meant to reduce available liquidity for these reserve and increase pressure of remaining borrowers.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230925_AaveV2_Eth_TUSDOffboardingPlanPartII/AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230925_AaveV2_Eth_TUSDOffboardingPlanPartII/AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x95cca29a9cdcaf51bb7331a9516d643a5c88f8ddce86c5f3920c2ae4d604193f)
- [Discussion](https://governance.aave.com/t/arfc-tusd-offboarding-plan-part-ii/14863)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
