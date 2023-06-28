---
title: Add FRAX Arbitrum Aave v3 
discussions: https://governance.aave.com/t/arfc-add-frax-arbitrum-aave-v3/13222
author: Flipside & TokenLogic
---

# Simple Summary

This publication presents the community an opportunity to add FRAX to the Arbitrum v3 Liquidity Pool.

# Motivation

FRAX can use its Lending AMO (similar to Maker’s DAI Direct Deposit Module) to mint protocol controlled FRAX to be lent out on Aave Protocol. Frax Finance has in the past done so in Aave v2 on Ethereum and has already stated on the Aave governance forum an interest in doing so on other deployments once FRAX is added.

The Frax Finance team could deploy a similar Aave Lending AMOs to Aave v3 after FRAX is listed. This will provide Aave users with access to FRAX and present an alternative to the four USD stable coins on Aave v3.

Users are able to borrow FRAX and earn yield across DeFi, such as on Curve Finance and Convex Finance.

# Specification

The parameters shown below are the combined recommendation of Gauntlet and Chaos Labs.

Ticker: FRAX

Contract Address: [`Abritrum: 0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F`](https://arbiscan.io/token/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F)

Chainlink Oracle Address: [`Arbitrum: 0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8`](https://arbiscan.io/address/0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8)

|Parameter|Value|
| --- | --- |
|Isolation Mode|Yes|
|Borrowable|Yes|
|Collateral Enabled|Yes|
|Supply Cap|7.00M units|
|Borrow Cap|5.50M units|
|Debt Ceiling| 1.00M units|
|LTV|70.00%|
|LT|75.00%|
|Liquidation Bonus|6.00%|
|Liquidation Protocol Fee|10.00%|
|Variable Base|0.00%|
|Variable Slope 1|4.00%|
|Variable Slope 2|75.00%|
|Uoptimal|80.00%|
|Reserve Factor|10.00%|
|Stable Borrowing|Disabled|
|Flashloanable|Yes|
|Siloed Borrowing|No|
|Borrowed in Isolation|No|

# References

[Forum Post](https://governance.aave.com/t/arfc-add-frax-arbitrum-aave-v3/13222)
[Payload Implementation](https://github.com/defijesus/aave-proposals/blob/frax-arb-v3/src/AaveV3ArbFraxListing_20230619/AaveV3ArbFraxListing_20230619.sol)
[Test](https://github.com/defijesus/aave-proposals/blob/frax-arb-v3/src/AaveV3ArbFraxListing_20230619/AaveV3ArbFraxListing_20230619.t.sol)
[Pre-Post Payload Diff](https://github.com/defijesus/aave-proposals/blob/frax-arb-v3/diffs/pre-Aave-V3-Arbitrum-FRAX-Listing_post-Aave-V3-Arbitrum-FRAX-Listing.md)
[Deployed Payload Address](https://arbiscan.io/address/0x449e1b11bf74d57972d2d2cf057b337b203490c4#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

The author, TokenLogic, receives payment indirectly from [Aave Grant DAO](https://twitter.com/AaveGrants) via [Butter](https://twitter.com/butterymoney) as part of the [Incentivised Delegate Campaign](https://governance.aave.com/t/temp-check-incentivized-delegate-campaign-3-month/11732). [TokenLogic is a delegate](https://governance.aave.com/t/tokenlogic-delegate-platform/12516) within Aave community. 

Delegate: [0xA06c2e5BB33cd6718b08EC9335081Cbba62861f7](https://app.aave.com/governance/)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).