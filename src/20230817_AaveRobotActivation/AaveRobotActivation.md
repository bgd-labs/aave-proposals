---
title: "Funding Aave Robot for Governance V2 Automation"
author: "BGD labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-robot-v1/13091/"
---

## Simple Summary

This proposal seeks to fund the operational cost of Aave Robot with LINK tokens from the Aave Collector contract which will help to perform automation on permissionless actions of Aave Governance v2. This proposal also reimburses BGD Labs for the LINK spent previously on the Aave Robot.

## Motivation

Given the nature of Aave Governance V2, certain permissionless actions such as `queue()`, `cancel()`, and `execute()` need to be called by any address when the conditions are met.

Manual initiation of these actions can result in unnecessary delays and expired proposals, especially when proposers are unaware of additional steps beyond proposal submission. To address these issues, and enhance the overall effectiveness of the Aave Governance, the implementation of the Aave Robot presents a solution leveraging Chainlink Automation to solve it.

After a period of testing by BGD Labs, this proposal seeks to fund the operational cost of the Aave Robot to automate key actions within Aave Governance V2, ultimately streamlining processes, and reducing friction.

## Specification

This proposal will transfer a total of: 1275 aLINK (~ $7500) from the collector contract across Ethereum, Polygon, Arbitrum, Optimism networks to the short Executor / Bridge Executor.
On the Short Executor / Bridge Executor, the aLINK tokens transferred will be withdrawn to the LINK tokens. In the case of Polygon, as the LINK withdrawn from the pool is not an ERC-677, the payload swaps it one-to-one using `PegSwap` to the ERC-677 LINK token.

<br>

Out of all the LINK tokens received, 675 LINK will be used to fund the pre-registered robot using the Aave CL Robot Operator contract by calling the `refillKeeper()` method.
Once the keeper is refilled, a total of 600 LINK will be transferred to BGD labs for their previous spending on the Aave Robot for operational expenses.

<br>

The `AaveCLRobotOperator` is a contract used to perform admin actions on the Aave Robot. An `AaveCLRobotOperator` is deployed on each network, which will allow for the DAO to have "admin" control on all the underlying robots, in order to register new ones, cancel or fund them with the LINK required for execution.

<br>

To simplify operational complexity the role of robot guardian will have the permissions to set the maximum gas limit of the keeper and to disable automation for certain governance proposals. This non-invasive role will be held by BGD Labs, as technical service provider engaged with the community.
Initially, BGD will keep the Robot Guardian role.

## References

- Keeper Contracts: [EthKeeper](https://etherscan.io/address/0x9EEa1Ba822d204077e9f90a92D30432417184587), [PolKeeper](https://polygonscan.com/address/0xDa98B308be8766501ec7Fe3eD9a48EfBD6c31a7B), [OptKeeper](https://optimistic.etherscan.io/address/0x102Bf2C03c1901AdBA191457A8c4A4eF18b40029), [ArbKeeper](https://arbiscan.io/address/0x864a6Aa4b8D4d84A7570fE2d0E4eCE8077AbcabB)
- AaveCLRobotOperator Contracts: [EthOperator](https://etherscan.io/address/0x020e452b463568f55bac6dc5afc8f0b62ea5f0f3), [PolOperator](https://polygonscan.com/address/0x4e8984d11a47ff89cd67c7651ecab6c00a74b4a9), [OptOperator](https://optimistic.etherscan.io/address/0x4f830bc2ddac99307a3709c85f7533842bda7c63), [ArbOperator](https://arbiscan.io/address/0xb0a73671c97bac9ba899cd1a23604fd2278cd02a)
- Implementation: [Ethereum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadEthereumRobot.sol), [Polygon](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadPolygonRobot.sol), [Optimism](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadOptimismRobot.sol), [Arbitrum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/src/proposal/ProposalPayloadArbitrumRobot.sol)
- BGD Robot Guardian: [Ethereum](https://etherscan.io/address/0xff37939808EcF199A2D599ef91D699Fb13dab7F7), [Polygon](https://polygonscan.com/address/0x7683177b05a92e8B169D833718BDF9d0ce809aA9), [Optimism](https://optimistic.etherscan.io/address/0x9867Ce43D2a574a152fE6b134F64c9578ce3cE03), [Arbitrum](https://arbiscan.io/address/0x87dFb794364f2B117C8dbaE29EA622938b3Ce465)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadEthereumRobot.t.sol), [Polygon](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadPolygonRobot.t.sol), [Optimism](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadOptimismRobot.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-governance-v2-robot/blob/main/tests/ProposalPayloadArbitrumRobot.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x763f55d7bc54c4e9699262d44522d16f789d14447815c344a977f0db5f90318b)
- [Discussion](https://governance.aave.com/t/bgd-aave-robot-v1/13091/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
