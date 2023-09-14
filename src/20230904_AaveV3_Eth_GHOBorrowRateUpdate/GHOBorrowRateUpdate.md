---
title: "GHO Borrow Rate Update"
author: "Marc Zeller (@mzeller) - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-increase-gho-borrow-rate/14612"
---

## Simple Summary

This AIP proposes an increase in the borrow rate of GHO from the current rate of 1.5% to 2.5%. The aim is to address the peg deviation of GHO and ensure its growth and trustworthiness in the market.

## Motivation

GHO has witnessed a rapid growth, reaching a circulating supply of 22M in just a few weeks since its launch. One of the primary reasons for this growth, especially in the current adverse market conditions, is the GHO borrow rate set below the market price of stablecoin borrows. This low rate, combined with the current lack of holding venues and the inability to use GHO as collateral, has made single-side liquidity provision in stableswaps, such as Balancer pools, [one of the most sought-after strategies.](https://aave.tokenlogic.com.au/liquidity)

While deep liquidity and growth are desired as a go-to-market strategy for GHO, the peg deviation of GHO (currently around $0.975) is affecting its growth and trust in the market. A consensus short-term solution to this issue is to slightly raise the GHO borrow rate from 1.5% to 2.5%. This rate remains attractive for borrowers and is still below the market average rates. However, by reducing the discount, it is anticipated to have a positive effect.

The discount for stkAave holders remains unchanged at 30%.

## Specification

- **Asset**: GHO
- **Contract Address**: 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f
- **Current Borrow Rate**: 1.5%
- **Proposed Borrow Rate**: 2.5%
- **New discounted Borrow Rate**: ~1.75%

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/AaveV3_Ethereum_GHOBorrowRateUpdate_20230904.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230904_AaveV3_Eth_GHOBorrowRateUpdate/AaveV3_Ethereum_GHOBorrowRateUpdate_20230904.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4b6c0daa24e0268c86ad1aa1a0d3ee32456e6c1ee64aaaab3df4a58a1a0adc04)
- [Discussion](https://governance.aave.com/t/arfc-increase-gho-borrow-rate/14612)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
