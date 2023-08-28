---
title: "LUSD collateral activation"
author: "Marc Zeller (@marczeller - Aave Chan Initiative)"
discussions: "https://governance.aave.com/t/arfc-activate-lusd-as-collateral-on-aave-v3-eth-pool/14199"
---

## Simple Summary
This AIP proposes to activate LUSD as a collateral asset on the Aave V3 ETH pool. The proposed risk parameters for LUSD will mirror those currently in place for USDC on the same pool.

## Motivation

LUSD is a decentralized stablecoin minted by users of the Liquity Protocol. It has demonstrated its resilience and maintained a stable peg, even in volatile market conditions. By adding LUSD as a collateral asset on the Aave V3 ETH pool, we can offer our users more options for their DeFi activities. Furthermore, the integration of LUSD could potentially synergize with the GHO, enhancing liquidity and further reinforcing the stability of the peg.

## Specification

The proposed risk parameters for LUSD on the Aave V3 ETH pool are as follows:

| Parameter | Value |
| --- | --- |
| Loan-to-Value (LTV) | 77% |
| Liquidation Threshold (LT) | 80% |
| Liquidation Penalty | 4.5% |
| Liquidation Protocol Fee | 10% |

These parameters are identical to those currently in place for USDC on the Aave V3 ETH pool.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230811_AaveV3_Eth_LUSDCollateralActivation/AaveV3_Ethereum_LUSDCollateralActivation_20230811.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230811_AaveV3_Eth_LUSDCollateralActivation/AaveV3_Ethereum_LUSDCollateralActivation_20230811.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4e17faf4fdb1ea2c8974d19e710724daf98dde225cd2078a9af4fbb5f0895512)
- [Discussion](https://governance.aave.com/t/arfc-activate-lusd-as-collateral-on-aave-v3-eth-pool/14199)

## Disclaimer

This proposal is part of the [Skyward](https://governance.aave.com/t/introducing-skyward-a-free-service-for-aave-dao-by-aave-chan-initiative/13173/13) program, the ACI has not been compensated by any third-party to present this ARFC.
At the time of writing, the author does not hold LQTY tokens but owns some LUSD.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
