---
title: Add GMX to Arbitrum Aave v3
discussions: https://governance.aave.com/t/arfc-add-gmx-to-arbitrum-v3/13768
author: Llama
---

# Summary

This publication presents the community an opportunity to add GMX to the Arbitrum Aave v3 Liquidity Pool.

# Motivation

GMX Protocol is the largest DEX offering derivatives and one of the most popular DeFi's today. GMX Token is also one of the highest traded assets on Arbitrum.

The GMX token is the utility, governance, and fee accrual token for the GMX protocol. The GMX value accrual mechanism is unique to the GMX protocol. GMX is a highly staked asset, with approximately 78% of circulating GMX staked earning an APR of [2.94%](https://app.gmx.io/#/earn). This staking yield may generate borrowing demand for GMX, noting the yield is volatile.

Adding the GMX token to Arbitrum Aave v3 support greater asset diversification. Users will be able to deposit GMX as collateral and borrow GMX leading to additional revenue opportunities for Aave.

This publication contains risk parameters provided by Chaos Labs and Gauntlet. The initial forum discussion can be found [here](https://governance.aave.com/t/temp-check-add-gmx-to-arbitrum-v3/12307/8).

# Specification

The parameters shown below are supported by Gauntlet and Chaos Labs.

Ticker: GMX

Contract Address: [`0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a`](https://arbiscan.io/token/0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a)

Chainlink Oracle GMX/USD [`0xdb98056fecfff59d032ab628337a4887110df3db`](https://arbiscan.io/address/0xdb98056fecfff59d032ab628337a4887110df3db)

| Parameter                          | Value         |
| ---------------------------------- | ------------- |
| Isolation Mode                     | Yes           |
| Borrowable                         | Yes           |
| Collateral Enabled                 | Yes           |
| Supply Cap                         | 110,000 units |
| Borrow Cap                         | 60,000 units  |
| Debt Ceiling                       | $2,500,000    |
| LTV                                | 45.00%        |
| LT                                 | 55.00%        |
| Liquidation Bonus                  | 8.00%         |
| Liquidation Protocol Fee           | 10.00%        |
| Variable Base                      | 0.00%         |
| Variable Slope1                    | 9.00%         |
| Variable Slope2                    | 300.00%       |
| Uoptimal                           | 45.00%        |
| Silo Borrowing                     | No            |
| eMode                              | No            |
| Reserve Factor                     | 20.00%        |
| Stable Borrowing                   | Disabled      |
| Stable Slope1                      | 13.00%        |
| Stable Slope2                      | 300.00%       |
| Base Stable Rate Offset            | 0.00%         |
| Stable Rate Excess Offset          | 13.00%        |
| Optimal Stable To Total Debt Ratio | 20.00%        |

# Implementation

A list of relevant links like for this proposal:

- [Governance Forum Discussion](https://governance.aave.com/t/arfc-add-gmx-to-arbitrum-v3/13768)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x1751d8de3c549ee99fbc9c1286d9575c482c3e639500dcc027455c8742d48bc9)
- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Arb_Listings_20231107/AaveV3_Arb_Listings_20231107_Test.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Arb_Listings_20231107/AaveV3_Arb_Listings_20231107_Payload.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

Neither @0xlide and/or @Llamaxyz are affiliated with GMX or any other entity and has not received payment to present this ARFC.

At the time of writing, both @0xlide and @llamaxyz, do not possess any GMX. @lide holds only a small amount of GLP.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
