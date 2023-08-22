---
title: CRV Aave V2 Ethereum - LT Reduction
author: Chaos Labs (@yonikesel, @ori-chaoslabs)
discussions: https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) for CRV on Aave V2 Ethereum.

## Motivation

Following the **[CRV V2 Ethereum Deprecation Plan](https://governance.aave.com/t/arfc-chaos-labs-crv-v2-ethereum-deprecation-plan/14364)** approved by the community and given the current market conditions and protocol usage, Chaos Labs and Gauntlet aligned on a 2% LT reduction.

Chaos originally proposed a 3% reduction, while Gauntlet proposed a 2% reduction. The individual analyses and considerations can be found in the forum [discussion](https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589).

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 49            | 47             | -2%    |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230822_AaveV2_Eth_CRVAaveV2Ethereum_LTReduction/AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230822_AaveV2_Eth_CRVAaveV2Ethereum_LTReduction/AaveV2_Eth_CRVAaveV2Ethereum_LTReduction_20230822_Test.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-crv-aave-v2-ethereum-lt-reduction-08-21-2023/14589)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
