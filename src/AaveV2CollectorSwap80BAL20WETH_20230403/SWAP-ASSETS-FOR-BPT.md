---
title: Treasury Management - Acquire B-80BAL-20WETH
discussions: https://governance.aave.com/t/deploy-bal-abal-from-the-collector-contract/9747
shortDescription: Aave DAO is to swap BAL and wETH to B-80BAL-20WETH via CoW Swap using Milkman to prevent MEV attacks, bad price slippage and reentrancy exploits
author: Llama (Fermin Carranza & TokenLogic)
created: 2023-05-17
---

# Summary

This proposal will convert Aave DAO's aBAL, aEthBAL, and BAL holdings, along with 326.88 wETH, on Ethereum to B-80BAL-20WETH.

# Abstract

Aave DAO will swap BAL and wETH for B-80BAL-20WETH via CoW Swap leveraging Milkman to protect the DAO from MEV exploits, incurring bad slippage and against reentrancy risk.

The methodology and payload have been developed and [tested](https://etherscan.io/tx/0x670b63d82a8d99b5aac74d25310e7ffa45c4dce2af9e1b5a265b0c84e90eba9f) in collaboration with Yearn Finance, CoW Swap, and Bored Ghosts Developing.

Aave DAO will convert 326.88 wETH plus all BAL, aBAL, and aEthBAL held within the Collector contract to B-80BAL-20WETH. Conversion of B-80BAL-20WETH to veBAL will occur via a separate proposal.

# Motivation

Aave DAO can utilize a veBAL holding in several ways, some of which are listed below:

- Support GHO liquidity pools with BAL emissions
- Direct BAL emissions to gauges where the BPT is listed as Collateral on Aave Protocol.
- Direct BAL emissions to the B-80AAVE-20WSTETH gauge, and others, in support of the Safety Module.

The proposed B-80BAL-20WETH holding, when converted to veBAL is to support all the initiatives listed above. Aave DAO retains the ability to add to the veBAL position over time as the DAO determines its longer-term strategy.

Details of events to date can be found below:

- [BAL <> AAVE token swap](https://governance.aave.com/t/arc-strategic-partnership-with-balancer-part-1/7617)
- [100k BAL acquisition](https://governance.aave.com/t/arc-strategic-partnership-with-balancer-part-2/7813)

For an in-depth overview of the implementation, please see this [forum post](https://governance.aave.com/t/deploy-bal-abal-from-the-collector-contract/9747/8).

At the time of writing Aave DAO owns 310,485.35 equivalent units of BAL at $4.50 for a total of $1,397,184.08.

- [300,000.000 units](https://etherscan.io/token/0xba100000625a3754423978a60c9317c58a424e3d?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) of BAL
- [10,054.76 units](https://etherscan.io/token/0x272f97b7a56a387ae942350bbc7df5700f8a4576?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) of aBAL
- [430.59 units](https://etherscan.io/token/0x2516e7b3f76294e03c42aa4c5b5b4dce9c436fb8?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c) of aethBAL

A total of 326.88 wETH is to be converted to B-80BAL-20wETH. The wETH is valued at $563,868.00 based upon a $1,725 wETH price.

The estimated total value of the B-80BAL-20WETH holding is $1,961,052.08.

[1 B-80BAL-20WETH = $12.56](https://etherscan.io/token/0x5c6ee304399dbdb9c8ef030ab642b10820db8f56)

Aave DAO can expect to receive approximately 156,134.72 units of B-80BAL-20WETH, minus price impact, etc. This places Aave DAO within the [top 15 B-80BAL-20WETH holders](https://dune.com/balancerlabs/veBAL-Analysis). When converted to veBAL, this is equivalent to 1.63% of the current veBAL supply.

# Specification

We will be leveraging [Milkman](https://github.com/charlesndalton/milkman) to do a contract-to-contract interaction. This allows the DAO to avoid the need to interact with the CoW Swap API offchain and allows for onchain enforceable dynamic slippage protection. In other words, the trade will execute only if the buy amount is higher than the minimum defined by the Milkman contract instance.

The highest profile trade to date using Milkman is the [ENS trade](https://docs.ens.domains/v/governance/governance-proposals/term-3/ep3.3-executable-sell-eth-to-usdc#specification).

The payload will do the following:

1. Handle approvals and transfers from the Collector contract onto a newly deployed COWTrader.sol contract
   a. Withdraw aBAL
   b. Withdraw aEthBAL
   c. Transfer all BAL now held in Collector to COWTrader.sol
   d. Transfer specified wETH quantity to COWTrader.sol
2. The COWTrader contract has one function to execute two trades using Milkman, utilizing its balance of wETH and BAL respectively. Both trades take the held token for B-80-BAL-20-WETH BPT.
3. Milkman creates a new instance per trade, which will then hold the funds until the trades are settled via CoW Swap. Under the hood, Milkman approves CoW Swap's Settlement contract so it can transfer funds once there is a match.
4. Once there is a match, the dynamic price checker will protect Aave's funds against a bad quote. If it passes our specified parameters, then the trade will go through and the Collector contract will receive B-80-BAL-20-WETH.

If everything goes well and the number of tokens to be received matches our parameters (slippage, price against our oracle) then the Collector contract will receive the BPT.

The trade can remain open in perpetuity until it is canceled or settled. The trade can be cancelled by either Aave Governance or an allowed Llama multi-sig. If cancelled, the tokens are sent automatically back to the collector.

# Implementation

A list of relevant links for this proposal:

- [Governance Forum Discussion](https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205)
- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2CollectorSwap80BAL20WETH_20230403/AaveV2CollectorSwapTest.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2CollectorSwap80BAL20WETH_20230403/AaveV2CollectorSwap80BAL20WETH_20230403_Payload.sol)
- [Trade Contract](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2CollectorSwap80BAL20WETH_20230403/COWTrader.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
