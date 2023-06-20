---
title: Add FRAX Ethereum Aave v3 
discussions: https://governance.aave.com/t/arfc-add-frax-to-aave-v3-ethereum/13051
shortDescription: Add FRAX Ethereum Aave v3 
author: Flipside & TokenLogic
---

# Simple Summary

This publication presents the community an opportunity to add FRAX to the Ethereum v3 Liquidity Pool.

# Motivation

FRAX can use its Lending AMO (similar to Maker’s DAI Direct Deposit Module) to mint protocol controlled FRAX to be lent out on Aave Protocol. Frax Finance has in the past done so in Aave v2 on Ethereum and has already stated on the Aave governance forum an interest in doing so on other deployments once FRAX is added.

The Frax Finance team could deploy a similar Aave Lending AMOs to Aave v3 after FRAX is listed.This will provide Aave users with access to FRAX and present an alternative to the four USD stable coins on Aave v3.

Users are able to borrow FRAX and earn yield across DeFi, such as on Curve Finance and Convex Finance.

# Specification

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

[Forum Post](TODO)
[Payload Implementation](TODO)
[Test](TODO)
[Pre-Post Payload Diff](TODO)
[Deployed Payload Address](TODO)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).