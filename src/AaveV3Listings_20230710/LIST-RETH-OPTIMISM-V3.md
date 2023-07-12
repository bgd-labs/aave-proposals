---
title: Add rETH Aave v3 Optimism
discussions: https://governance.aave.com/t/arfc-add-reth-aave-v3-optimism/13795
author: Llama
---

# Summary

Add rETH to Aave v3 Optimism as collateral and to the ETH correlated eMode.

# Motivation

rETH is currently listed on Aave v3 Ethereum and Arbitrum. ETH correlated assets make up over half of Aave's TVL on Optimism. By adding rETH and providing LST diversification, Aave presents itself as a neutral platform offering users the choice between various LSTs.

rETH is listed on Aave v3 Ethereum and has over $58M of deposits. Rocket Pool is expanding its support for rETH across the L2 ecosystem and, recently, a Chainlink oracle was published enabling rETH to be added to Aave Protocol. With the release of this oracle, this publication proposes adding rETH to Aave v3 on Optimism.

LST collateral types drive material borrowing revenue to Aave as users deposit the LST and borrow the corresponding network token. This is most evident on Ethereum where the LST-wETH-yield-maximising loop is the source of the vast majority of wETH borrowing demand.

An added benefit of offering a variety of LSTs is the respective communities may elect to compete for user acquisition via Aave through offering incentives. This is currently happening on Aave v3 Polygon and Aave’s TVL has meaningfully increased from a relatively small base.

# Specification

Ticker: rETH

Contract Address: `Optimism:0x9Bcef72be871e61ED4fBbc7630889beE758eb81D`

rETH/ETH exchange rate: `Optimism: 0x22F3727be377781d1579B7C9222382b21c9d1a8f`

| Parameter                          | Value       |
| ---------------------------------- | ----------- |
| Isolation Mode                     | No          |
| Borrowable                         | Yes         |
| Collateral Enabled                 | Yes         |
| Supply Cap                         | 6,000 units |
| Borrow Cap                         | 720 units   |
| LTV                                | 67.00%      |
| LT                                 | 74.00%      |
| Liquidation Bonus                  | 7.50%       |
| Liquidation Protocol Fee           | 10.00%      |
| Reserve Factor                     | 15.00%      |
| Variable Base                      | 0.00%       |
| Variable Slope 1                   | 7.00%       |
| Variable Slope 2                   | 300.00%     |
| Uoptimal                           | 45.00%      |
| Stable Borrowing                   | Disabled    |
| Stable Slope 1                     | 13.00%      |
| Stable Slope 2                     | 300.00%     |
| Base Stable Rate Offset            | 3.00%       |
| Stable Rate Excess Offset          | 5.00%       |
| Optimal Stable to Total Debt Ratio | 20.00%      |
| Flahloanable                       | Yes         |
| Siloed Borrowing                   | No          |
| Borrowed in Isolation              | No          |

Optimism -Ethereum Correlated eMode Category

Add rETH to Category 2 eMode (ETH correlated)

| Parameter             | Value              |
| --------------------- | ------------------ |
| Category              | 2 (ETH Correlated) |
| Assets                | wstETH, wETH,rETH  |
| Loan to Value         | 90.00%             |
| Liquidation Threshold | 93.00%             |
| Liquidation Bonus     | 1.00%              |

# Implementation

A list of relevant links like for this proposal:

- [Governance Forum Discussion](https://governance.aave.com/t/arfc-add-reth-aave-v3-optimism/13795)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb112684943ef900f2918ccbc4de3bb3091869eaeb6b3c15cc26805c17cb6a9f6)
- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Listings_20230710/AaveV3OPListings_20230710_Payload_Test.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Listings_20230710/AaveV3OPListings_20230710_Payload.sol)

The proposal Payload was reviewed by [Bored Ghosts Developing](https://bgdlabs.com/).

# Disclaimer

Llama is a service provider to the Aave DAO and does not receive anything outside of this agreement for the publication of this proposal.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
