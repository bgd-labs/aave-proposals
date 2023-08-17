---
title: "Funding Aave Robot for Governance V2 Automation"
author: "BGD labs"
discussions: "https://governance.aave.com/t/bgd-aave-robot-v1/13091/"
---

## Simple Summary

This proposal seeks to fund the operational cost of Aave Robot with Link tokens from the collector contract which will help to perform automation on permissionless actions of Aave Governance v2.

## Motivation

Given the nature of Aave Governance V2, certain actions such as `queue()`, `cancel()`, and `execute()` are completely permissionless and are needed to be called by any address when the conditions are met. Manual initiation of these actions can result in unnecessary delays and expired proposals, especially when proposers is unaware of additional steps beyond proposal submission. To address these issues, and enhance the overall effectiveness of the Aave Governance, the implementation of the Aave Robot presents a solution leveraging chainlink automation to solve it. This proposal seeks to fund the operational cost of the Aave Robot to automate key actions within Aave Governance V2, ultimately streamlining processes, reducing friction.

## Specification

This proposal will transfer a total of: 375 aLink (~ $2500) from the collector contract across ethereum, polygon, arbitrum, optimism networks to the short executor / bridge executor. On the short executor / bridge executor, the aLink tokens transferred will be withdrawn to the Link tokens. In case of polygon, as the Link withdrawn from the pool is not an ERC-677, so we swap it one to one using PegSwap to ERC-677 Link token. The Link tokens received will be used to fund the pre-registered robot using the Aave CL Robot Operator contract by calling the `refillKeeper()` method.

The AaveCLRobotOperator is a contract which is used to perform admin actions on the Aave Robot, a AaveCLRobotOperator is deployed on each network, that will allow for the DAO to have "admin" control on all the underlying robots, in order to register new ones, cancel or funding them with the Link required for execution. To simplify operational complexity the role of robot guardian will have the permissions to set the maximum gas limit of the keeper and to disable automation for certain governance proposals.
Initially, BGD will keep the Robot Guardian role.

## References

- Keeper Contracts: [EthKeeper](https://etherscan.io/address/0x9EEa1Ba822d204077e9f90a92D30432417184587), [PolKeeper](https://polygonscan.com/address/0xDa98B308be8766501ec7Fe3eD9a48EfBD6c31a7B), [OptKeeper](https://optimistic.etherscan.io/address/0x102Bf2C03c1901AdBA191457A8c4A4eF18b40029), [ArbKeeper](https://arbiscan.io/address/0x864a6Aa4b8D4d84A7570fE2d0E4eCE8077AbcabB)
- AaveCLRobotOperator Contracts: [EthOperator](https://etherscan.io/address/0x020e452b463568f55bac6dc5afc8f0b62ea5f0f3), [PolOperator](https://polygonscan.com/address/0x4e8984d11a47ff89cd67c7651ecab6c00a74b4a9), [OptOperator](https://optimistic.etherscan.io/address/0x4f830bc2ddac99307a3709c85f7533842bda7c63), [ArbOperator](https://arbiscan.io/address/0xb0a73671c97bac9ba899cd1a23604fd2278cd02a)
- Implementation: [Ethereum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadEthereumRobot.sol) [Polygon](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadPolygonRobot.sol) [Optimism](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadOptimismRobot.sol) [Arbitrum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadArbitrumRobot.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadEthereumRobot.t.sol) [Polygon](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadPolygonRobot.t.sol) [Optimism](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadOptimismRobot.t.sol) [Arbitrum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadArbitrumRobot.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x763f55d7bc54c4e9699262d44522d16f789d14447815c344a977f0db5f90318b)
- [Discussion](https://governance.aave.com/t/bgd-aave-robot-v1/13091/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
