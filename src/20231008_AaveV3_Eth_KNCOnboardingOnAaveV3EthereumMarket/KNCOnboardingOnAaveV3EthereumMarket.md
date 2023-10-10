---
title: "KNC onboarding on AaveV3 Ethereum market"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-knc-onboarding-on-aavev3-ethereum-market/14972"
---

## Simple Summary

This AIP is proposing to add the KNC token from Kyberswap to the AaveV3 Ethereum market in isolation mode.

## Motivation

KyberSwap is a multi-chain DEX aggregator + concentrated liquidity platform, that aims to offer superior rates for traders and capital-efficient returns for liquidity providers.

As one of the oldest and most popular DEX aggregators with an average of 500K web visitors per month. KyberSwap has already been deployed on 14 chains, including Ethereum, Polygon, Arbitrum, Optimism, Avalanche, and Base. Total trading volume has crossed $21B+ and the current total value locked (TVL) on all chains is $60M+.

KNC is Kyber’s utility and governance token and an important part of KyberSwap operations. KNC holders can stake KNC to vote on proposals to improve KyberSwap. In return, KNC voters receive rewards from fees collected through trading on KyberSwap and other ecosystem collaborations. As more trades are executed and new protocols are added, more rewards are generated.

Adding support for KNC on Ethereum V3 in isolated mode would allow KNC holders to borrow stablecoins by leveraging their KNC position, attracting new KNC deposits, which would add a new revenue stream for Aave while limiting the exposure.

## Specification

We propose the following parameters according to Gauntlet and ChaosLabs's recommendations:
| Parameter | Value |
| --- | --- |
| Isolation Mode | Yes |
| Borrowable | Yes |
| Collateral Enabled | Yes |
| Supply Cap (KNC) | 1.200.000 |
| Borrow Cap (KNC) | 650,000 |
| Debt Ceiling | 1M$ |
| LTV | 35.00% |
| LT | 40.00% |
| Liquidation Bonus | 10.00% |
| Liquidation protocol Fee | 10.00% |
| Variable Base | 0.00% |
| Variable Slope1 | 9.00% |
| Variable Slope2 | 300.00% |
| Uoptimal | 45.00% |
| Reserve Factor | 20.00% |
| Stable Borrowing | Disabled |
| Stable Slope1 | 13.00% |
| Stable Slope2 | 300.00% |
| Base Stable Rate Offset | 3.00% |
| Stable Rate Excess Offset | 5.00% |
| Optimal Stable To Total Debt Ratio | 20.00% |
| Flahloanable | Yes |
| Siloed Borrowing | No |
| Borrowed in Isolation | No |

- **Ticker:** KNC
- **Contract Address:** [0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202](https://etherscan.io/address/0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202)
- **Chainlink Oracle:** [0xf8ff43e991a81e6ec886a3d281a2c6cc19ae70fc](https://etherscan.io/address/0xf8ff43e991a81e6ec886a3d281a2c6cc19ae70fc)

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231008_AaveV3_Eth_KNCOnboardingOnAaveV3EthereumMarket/AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231008_AaveV3_Eth_KNCOnboardingOnAaveV3EthereumMarket/AaveV3_Ethereum_KNCOnboardingOnAaveV3EthereumMarket_20231008.t.sol)
- [Snapshot](https://signal.aave.com/#/proposal/0xa162335479f27fe1bf4482da63e1f6fa246b0fd770d913d8ba89bd56a5aa644f)
- [Discussion](https://governance.aave.com/t/arfc-knc-onboarding-on-aavev3-ethereum-market/14972)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
