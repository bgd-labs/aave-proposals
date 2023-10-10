---
title: "STG onboarding on AaveV3 Ethereum Market"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-stg-onboarding-on-aavev3-ethereum-market/14973"
---

## Simple Summary

This ARFC is proposing to add the STG token from Stargate to the AaveV3 Ethereum market in isolation mode.

## Motivation

Stargate is a composable, omnichain bridge built on top of the LayerZero protocol. Its goal is to bring enhanced utility to users and Dapps by allowing the transfer of assets across chains from unified liquidity with immediate and guaranteed finality.

Having reached $15 Billion in cumulative volume and ranked first in bridged volume over the last month, Stargate is becoming the most used bridge. Its token, the STG is using a linear ve-locking to offer governance power and fee redistribution to it’s users. With a circulating supply of 200M over the 1000M expected it brings the capitalization to $90M.

Integrating the STG token into the Ethereum Aave v3 will enhance asset diversification, offering borrowers and lenders expanded avenues to leverage the protocol. This integration will empower users to deposit STG as collateral and borrow STG, paving the way for new revenue streams for Aave.

This onboarding is considered in isolation mode with conservative LTV and debt ceiling parameters to limit protocol exposure.

## Specification

We propose the followings parameters in accordfance with the risk providers
| Parameter | Value |
| --- | --- |
| Isolation Mode | Yes |
| Borrowable | Yes |
| Collateral Enabled | Yes |
| Supply Cap (STG) | 10,000,000 |
| Borrow Cap (STG) | 5,500,000 |
| Debt Ceiling | 3M$ |
| LTV | 35.00% |
| LT | 40.00% |
| Liquidation Bonus | 10.00% |
| Liquidation Protocol Fee | 10.00% |
| Variable Base | 0.00% |
| Variable Slope1 | 7.00% |
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

- **Ticker**: STG
- **Contract Address**: [0xaf5191b0de278c7286d6c7cc6ab6bb8a73ba2cd6](https://etherscan.io/address/0xaf5191b0de278c7286d6c7cc6ab6bb8a73ba2cd6)
- **Chainlink Oracle STG/USD**: [0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d](https://etherscan.io/address/0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d)

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231008_AaveV3_Eth_STGOnboardingOnAaveV3EthereumMarket/AaveV3_Ethereum_STGOnboardingOnAaveV3EthereumMarket_20231008.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231008_AaveV3_Eth_STGOnboardingOnAaveV3EthereumMarket/AaveV3_Ethereum_STGOnboardingOnAaveV3EthereumMarket_20231008.t.sol)
- [Snapshot](https://signal.aave.com/#/proposal/0x917d0a2c0d9a107d5f8c83b76c291bb34a6a94b85b833b2add96bce7681522ef)
- [Discussion](https://governance.aave.com/t/arfc-stg-onboarding-on-aavev3-ethereum-market/14973)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
