---
title: Add RPL to Aave V3 Ethereum pool
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-add-rpl-to-ethereum-v3/13181
---

## Simple Summary

This AIP presents the community with the opportunity to add RPL to the Ethereum v3 Liquidity Pool.

## Motivation

Rocket Pool is an Ethereum staking protocol. The protocol reduces ETH staking capital and hardware requirements to increase Ethereum’s decentralization and security. Rocket Pool lets customers stake trustlessly to a network of node operators to do this. Adding support for RPL on Ethereum V3 would allow RPL holders to obtain a passive yield on their holdings without the need to deploy mini-pools.
On their side, RPL borrowers would be able to participate in Rocket Pool staking without the need to invest in RPL.

RPL is the governance and utility token for RocketPool, a major decentralized liquid staking Token protocol. RocketPool has solidified itself as a Protocol which is actively contributing to Ethereum’s decentralization by making Operating a Node easy and accessible. By supporting RPL on Aave V3 Ethereum we would create an alternative for RPL holders who wish to earn yield on their asset.

## Specification

Ticker: RPL

Contract Address: [0xD33526068D116cE69F19A9ee46F0bd304F21A51f](https://etherscan.io/address/0xD33526068D116cE69F19A9ee46F0bd304F21A51f)`

| Parameter                | Value    |
| ------------------------ | -------- |
| Isolation Mode           | No       |
| Borrowable               | Yes      |
| Collateral Enabled       | No       |
| Supply Cap (RPL)         | 105,000  |
| Borrow Cap (RPL)         | 105,000  |
| Debt Ceiling             | N/A      |
| LTV                      | N/A      |
| LT                       | N/A      |
| Liquidation Bonus        | N/A      |
| Liquidation Protocol Fee | 10%      |
| Variable Base            | 0.00%    |
| Variable Slope1          | 8.50%    |
| Variable Slope2          | 87.00%   |
| Uoptimal                 | 80.00    |
| Reserve Factor           | 20.00%   |
| Stable Borrowing         | Disabled |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_AaveV3ListRPL_20230711/AaveV3_Eth_AaveV3ListRPL_20230711.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_AaveV3ListRPL_20230711/AaveV3_Eth_AaveV3ListRPL_20230711.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x036f9ce8b4a9fef0156ccf6b2a205d56d4f23b7ab9a485a16d7c8173cd85a316)
- [Discussion](https://governance.aave.com/t/arfc-add-rpl-to-ethereum-v3/13181)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
