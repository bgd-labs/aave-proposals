---
title: "Enhancing Aave DAO’s Liquidity Incentive Strategy on Balancer"
author: "Marc Zeller - Aave-Chan Initiative, Karpatkey"
discussions: "https://governance.aave.com/t/arfc-enhancing-aave-daos-liquidity-incentive-strategy-on-balancer/15061"
---

## Simple Summary

This AIP proposes Aave DAO to:

- Mint auraBAL using existing B-80BAL-20WETH holdings and stake it on Aura Finance's Classic Staking Pool;
- Buy 400,000 USDC worth of AURA OTM
- Swap $200,000 worth of AAVE for AURA and 200,000 USDC for AURA in an OTC deal with AURA DAO.
- Send the proceeds to the GHO Liquidity Commitee (GLC) to operate.

## Motivation

This AIP is part of the GHO overall support and aims at creating deeper GHO secondary liquidity in the balancer ecosystem. It also aims at providing funding to the GLC to operate.

## Specification

The Aave DAO treasury currently holds 157,169 B-80BAL-20WETH and 443,674 AURA. To optimise Aave DAO's voting incentives and maximise its emission power, we propose to:

## 1. Mint auraBAL using existing B-80BAL-20WETH holdings and stake it on Aura Finance's Classic Staking Pool.

Aura Finance's classic staking pool currently yields 17.46% APR: 9.61% in BAL and 7.85% in AURA. The rewards resulting from minting 157,169 auraBAL can be used to bribe vlAURA holders, generating a weekly budget of $4,907.87 that can bribe 701,124.38 vlAURA per week at current market prices.

It also increases Aura's veBAL capture share, enhancing Aave's vlAURA emission power by 1.15%.

## 2. Buy 400,000 USDC worth of AURA OTM

We recommend using [CowSwap's TWAP](https://swap.cow.fi/#/1/advanced/USDC/AURA?tab=open&page=1) for the execution, dividing the purchase into ten transactions of equal amounts, each with a 1-hour duration. This reduces the price impact to 2,02% at current liquidity levels.

## 3. Swap $200,000 worth of AAVE for AURA and 200,000 USDC for AURA in an OTC deal with AURA DAO.

This action can be achieved by transferring 2,965.35 AAVE from the ecosystem reserve and 200,000 USDC from the collector to a token swap contract with properties similar to the one used for the [CRV OTC deal](https://github.com/bgd-labs/aave-proposals/blob/b2ad17f846d3442bf09e7edf5db957fae88b655d/src/AaveV2_Eth_CRV_OTC_Deal_20230508/AaveV2_Eth_CRV_OTC_Deal_20230508.sol).

We'd be exchanging 2,965.35 AAVE and 200,000 USDC for 477,088.51 AURA with the AURA DAO. The TWAP prices for AURA and AAVE were calculated for the period from September 29th to October 6th and can be found [here](https://docs.google.com/spreadsheets/d/1_oogFs9V-fZQkxj-dBpO8YCLLHEI2YneFHeCtzL501s/edit?usp=sharing).

# Projected Emission Power

The acquired assets will be staked and locked into Aura Finance, generating the following emission power:

- **$17,713.16** in weekly emissions derived from 1,392,955.28 vlAURA holdings;
- **$8,915.97** in weekly emissions by minting 157,169.86 auraBAL staked on the AuraBAL classic pool and using the rewards to bribe vlAURA holders in incentive markets; which
- Leads to a total of **$26,629.73** in weekly emission power.

Details on emission power calculations and TWAP for AAVE and AURA can be found below:

https://docs.google.com/spreadsheets/d/1_oogFs9V-fZQkxj-dBpO8YCLLHEI2YneFHeCtzL501s/edit?usp=sharing

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/b2ad17f846d3442bf09e7edf5db957fae88b655d/src/20231017_AaveV3_Eth_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer/AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/b2ad17f846d3442bf09e7edf5db957fae88b655d/src/20231017_AaveV3_Eth_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer/AaveV3_Ethereum_EnhancingAaveDAOSLiquidityIncentiveStrategyOnBalancer_20231017.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xd1136b4db12346a95870f5a52ce02ef1bd4fb83cbbbf56c709aa14ae2d38659b)
- [Discussion](https://governance.aave.com/t/arfc-enhancing-aave-daos-liquidity-incentive-strategy-on-balancer/15061)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
