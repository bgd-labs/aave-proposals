---
title: Bug Bounty 2023_07_10
author: BGD labs
discussions: https://governance.aave.com/t/bgd-bug-bounties-proposal/13077
---

## Simple Summary

This proposal executes the bug bounty payout for recent findings.

According to the discussion on the governance forum and the passing Snapshot vote, the amounts to transfer are as follows:

Emanuele Ricci (0x7dF98A6e1895fd247aD4e75B8EDa59889fa7310b): 35,000 USD
kankodu (0xb91F64b7CD46e5cF5C0735d42D8292576aD45FAb): 20,000 USD
Watchpug (0x192bDD30D272AabC2B1c3c719c518F0f2d10cc60): 10,000 USD
cmichel (0x7ac71b1944869c13b36bfb25d7623723d288e6b2): 20,000 USD

The bounties will be paid out in Aave V2 aUSDT (0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811) from the Collector (0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c).

## Motivation

In order to ensure the security of the Aave protocol, it is imperative that the Aave DAO fairly rewards bug bounty hunters for their contribution.

## Specification

Transfer outlined amounts to specified addresses.

## References

- Implementation: [Ethereum](src/AaveV3_Eth_BugBounty_20230710/AaveV3_Eth_BugBounty_20230710.sol)
- Tests: [Ethereum](src/AaveV3_Eth_BugBounty_20230710/AaveV3_Eth_BugBounty_20230710.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x6f70e60abd398e1ff04ff6a78cd313b69d47df84e42b790c14c273dc5ab31674)
- [Discussion](https://governance.aave.com/t/bgd-bug-bounties-proposal/13077)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
