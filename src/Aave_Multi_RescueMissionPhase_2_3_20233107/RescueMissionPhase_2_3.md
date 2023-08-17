---
title: Rescue Mission Phase 2, 3
author: BGD labs
discussions: https://governance.aave.com/t/bgd-rescue-mission-phase-2-3/14309
---

## Simple Summary
This proposal outlines the final stages of the "Rescue Mission" for tokens erroneously sent to Aave ecosystem smart contracts. Phase 2 and 3 amalgamates the efforts of both phases into a single proposal, covering tokens locked in Aave v1, v2, v2 amm and v3 contracts (across various networks) provided their aggregated value exceeds $1,000. The proposal aims to release these locked tokens which the users can claim by interacting with the Rescue Mission smart contract, or via the utility interface available on https://rescue.bgdlabs.com/

## Motivation
As an item part of the Aave <> BGD engagement Phase 1 described here, the rescue mission was created to support users of the Aave ecosystem who sent by mistake the tokens to the wrong smart contract addresses. While Phase 1 of the Rescue Mission has been completed, phases 2 and 3 remained pending. After evaluating the necessary interactions for both phases, it was decided to present them as a unified proposal.

The following table represents the tokens to rescue from various aave ecosystem contracts:

| Tokens to Rescue                                                                             | Contract where tokens are stuck                                                                    | Amount                  | Network   |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ----------------------- | --------- |
| [AAVE V2 A_RAI](https://etherscan.io/address/0xc9BC48c72154ef3e5425641a3c747242112a46AF)     | [AAVE V2 A_RAI](https://etherscan.io/address/0xc9BC48c72154ef3e5425641a3c747242112a46AF)           | 1481.16074087007480402  | ETHEREUM  |
| [AAVE V1 A_WBTC](https://etherscan.io/address/0xFC4B8ED459e00e5400be803A9BB3954234FD50e3)    | [AAVE V1 POOL](https://etherscan.io/address/0x398eC7346DcD622eDc5ae82352F02bE94C62d119)            | 1.92454215              | ETHEREUM  |
| [USDT](https://etherscan.io/address/0xdac17f958d2ee523a2206206994597c13d831ec7)              | [AAVE V2 AMM_POOL](https://etherscan.io/address/0x7937D4799803FbBe595ed57278Bc4cA21f3bFfCB)        | 20600.057405            | ETHEREUM  |
| [DAI](https://etherscan.io/address/0x6b175474e89094c44da98b954eedeac495271d0f)               | [AAVE V2 POOL](https://etherscan.io/address/0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9)            | 22000                   | ETHEREUM  |
| [GUSD](https://etherscan.io/address/0x056fd409e1d7a124bd7017459dfea2f387b6d5cd)              | [AAVE V2 POOL](https://etherscan.io/address/0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9)            | 19994.86                | ETHEREUM  |
| [LINK](https://etherscan.io/address/0x514910771af9ca656af840dff83e8264ecf986ca)              | [AAVE V1 POOL](https://etherscan.io/address/0x398eC7346DcD622eDc5ae82352F02bE94C62d119)            | 4084                    | ETHEREUM  |
| [USDT](https://etherscan.io/address/0xdac17f958d2ee523a2206206994597c13d831ec7)              | [AAVE V2 A_USDT](https://etherscan.io/address/0x3Ed3B47Dd13EC9a98b44e6204A523E766B225811)          | 11010                   | ETHEREUM  |
| [USDC](https://etherscan.io/address/0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48)              | [AAVE V2 POOL](https://etherscan.io/address/0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9)            | 1089.889717             | ETHEREUM  |
| [WBTC](https://polygonscan.com/address/0x1bfd67037b42cf73acf2047067bd4f2c47d9bfd6)           | [AAVE V2 POOL](https://polygonscan.com/address/0x8dFf5E27EA6b7AC08EbFdf9eB090F32ee9a30fcf)         | 0.22994977              | POLYGON   |
| [AAVE V2 A_DAI](https://polygonscan.com/address/0x27F8D03b3a2196956ED754baDc28D73be8830A6e)  | [AAVE V2 A_DAI](https://polygonscan.com/address/0x27F8D03b3a2196956ED754baDc28D73be8830A6e)        | 4250.580268097645600939 | POLYGON   |
| [AAVE V2 A_USDC](https://polygonscan.com/address/0x1a13F4Ca1d028320A707D99520AbFefca3998b7F) | [AAVE V2 A_USDC](https://polygonscan.com/address/0x1a13F4Ca1d028320A707D99520AbFefca3998b7F)       | 514131.378018           | POLYGON   |
| [USDC](https://polygonscan.com/address/0x2791bca1f2de4661ed88a30c99a7a9449aa84174)           | [AAVE V2 POOL](https://polygonscan.com/address/0x8dFf5E27EA6b7AC08EbFdf9eB090F32ee9a30fcf)         | 4515.242949             | POLYGON   |
| [USDT.e](https://snowtrace.io/address/0xc7198437980c041c805a1edcba50c1ce5db95118)            | [AAVE V2 POOL](https://snowtrace.io/address/0x4F01AeD16D97E3aB5ab2B501154DC9bb0F1A5A2C)            | 1772.206585             | AVALANCHE |
| [USDC.e](https://snowtrace.io/address/0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664)            | [AAVE V2 POOL](https://snowtrace.io/address/0x4F01AeD16D97E3aB5ab2B501154DC9bb0F1A5A2C)            | 2522.408895             | AVALANCHE |
| [USDC](https://optimistic.etherscan.io/address/0x7f5c764cbc14f9669b88837ca1490cca17c31607)   | [AAVE V3 POOL](https://optimistic.etherscan.io/address/0x794a61358D6845594F94dc1DB02A252b5b4814aD) | 44428.421035            | OPTIMISM  |


## Specification

For wallets to be able to claim the tokens they sent to the contracts specified on Phase 2 and 3, we have created a different Merkle tree for every claimable token. With the roots and amounts, every wallet will be able to claim by calling the AaveMerkleDistributor contract similar to what was being done in Phase 1. For more details of which wallets are eligible for claims you can check [here](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/js-scripts/maps/usersAmounts.json).

The following Aave contracts will updated by adding a rescue function that can transfer the stuck funds to the Merkle distributor contract by the payloads.

- Aave v1 pool
- Aave v2 amm pool
- Aave v2 ethereum pool
- Aave v2 polygon pool
- Aave v2 avalanche pool
- Aave v2 aRai contract on ethereum
- Aave v2 aUsdt contract on ethereum
- Aave v2 aDai contract on polygon
- Aave v2 aUsdc contract on polygon
- Aave v3 pool on optimism

Once the contracts are updated, the payload will activate the Merkle distributor contract and rescue the stuck funds and send it to the Merkle distributor contract. For ethereum network we will use the same Merkle distributor contract as in Phase 1, while for other networks new ones will be deployed with the owner of the Merkle distributor set as the short executor.

_Note: The payload on avalanche will be executed by the guardian_

## Security Considerations

- Implementation diffs have been generated to see that the new implementations only differ on the rescue logic.
- Storage layouts diffs have also been generated for the contracts where the implementation is updated.

Both the implementation diffs and storage diffs for all the contracts can be found [here](https://github.com/bgd-labs/rescue-mission-phase-2-3/tree/main/diffs).

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/src/contracts/EthRescueMissionPayload.sol), [Polygon](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/src/contracts/PolRescueMissionPayload.sol), [Avalanche](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/src/contracts/AvaRescueMissionPayload.sol), [Optimism](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/src/contracts/OptRescueMissionPayload.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/tests/EthRescueMissionPayload.t.sol), [Polygon](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/tests/PolRescueMissionPayload.t.sol), [Avalanche](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/tests/AvaRescueMissionPayload.t.sol), [Optimism](https://github.com/bgd-labs/rescue-mission-phase-2-3/blob/main/tests/OptRescueMissionPayload.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-rescue-mission-phase-2-3/14309)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
