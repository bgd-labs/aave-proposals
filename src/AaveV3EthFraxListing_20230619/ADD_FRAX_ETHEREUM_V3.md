---
title: Add FRAX Ethereum Aave v3 
discussions: https://governance.aave.com/t/arfc-add-frax-to-aave-v3-ethereum/13051
author: Flipside & TokenLogic
---

# Simple Summary

This publication presents the community an opportunity to add FRAX to the Ethereum v3 Liquidity Pool.

# Motivation

FRAX can use its Lending AMO (similar to Maker’s DAI Direct Deposit Module) to mint protocol controlled FRAX to be lent out on Aave Protocol. Frax Finance has in the past done so in Aave v2 on Ethereum and has already stated on the Aave governance forum an interest in doing so on other deployments once FRAX is added.

The Frax Finance team could deploy a similar Aave Lending AMOs to Aave v3 after FRAX is listed. This will provide Aave users with access to FRAX and present an alternative to the four USD stable coins on Aave v3.

Users are able to borrow FRAX and earn yield across DeFi, such as on Curve Finance and Convex Finance.

# Specification

The parameters shown below are the combined recommendation of Gauntlet and Chaos Labs.

Ticker: FRAX

Contract Address: [Ethereum: 0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e)

Oracle Address: [`Ethereum: 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD`](https://etherscan.io/address/0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD)

|Parameter|Value|
| --- | --- |
|Isolation Mode|Yes|
|Borrowable|Yes|
|Collateral Enabled|Yes|
|Supply Cap|15.00M units|
|Borrow Cap|12.00M units|
|Debt Ceiling| 10.00M units|
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

[Forum Post](https://governance.aave.com/t/arfc-add-frax-to-aave-v3-ethereum/13051)
[Payload Implementation](https://github.com/defijesus/aave-proposals/blob/frax-eth-v3/src/AaveV3EthFraxListing_20230619/AaveV3EthFraxListing_20230619.sol)
[Test](https://github.com/defijesus/aave-proposals/blob/frax-eth-v3/src/AaveV3EthFraxListing_20230619/AaveV3EthFraxListing_20230619.t.sol)
[Pre-Post Payload Diff](https://github.com/defijesus/aave-proposals/blob/frax-eth-v3/diffs/pre-Aave-V3-Ethereum-FRAX-Listing_post-Aave-V3-Ethereum-FRAX-Listing.md)
[Deployed Payload Address](https://etherscan.io/address/0x56cf1dbd6cfca7898ba6a96ce1fbf1f038e6466b#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

The author, TokenLogic, receives payment indirectly from [Aave Grant DAO](https://twitter.com/AaveGrants) via [Butter](https://twitter.com/butterymoney) as part of the [Incentivised Delegate Campaign](https://governance.aave.com/t/temp-check-incentivized-delegate-campaign-3-month/11732). [TokenLogic is a delegate](https://governance.aave.com/t/tokenlogic-delegate-platform/12516) within Aave community. 

Delegate: [0xA06c2e5BB33cd6718b08EC9335081Cbba62861f7](https://app.aave.com/governance/)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).