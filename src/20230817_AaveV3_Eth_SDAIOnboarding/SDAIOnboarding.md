---
title: "sDAI onboarding"
author: "Marc Zeller (@marczeller - Aave Chan Initiative)"
discussions: "https://governance.aave.com/t/arfc-sdai-aave-v3-onboarding/14410"
---

## Simple Summary

This proposal seeks to onboard sDAI as a collateral-only asset into the Aave V3 Ethereum pool. It outlines the specific parameters for integration and aims to create new synergies with the MakerDAO ecosystem.

## Motivation

The recent increase in the DSR (Dai Savings Rate) to 8%—though anticipated to decrease to 5%—presents a unique opportunity for Aave to forge new synergies with the MakerDAO ecosystem. By integrating liquid DSR deposit tokens (sDAI) as a collateral-only asset in the Aave V3 Ethereum pool, Aave can offer users the dual benefit of earning DSR yield while utilizing their assets as collateral. In the context of GHO, this integration would create a yield-generating stablecoin with a higher yield than the GHO borrow cost. It's important to note that this proposal does not conflict with the [DSR integration in aDAI reserve proposal](https://governance.aave.com/t/temp-check-integrating-makerdaos-dsr-into-aave-v3-ethereum-pool/13360), but rather complements it. However, current engineering constraints make immediate integration difficult in the short-term. Should governance approve this proposal, both sDAI and DAI would serve as reserves in the Aave V3 Ethereum pool, with sDAI primarily used as collateral and DAI as a borrowable asset.

## Specification

We propose the following modifications to the Aave V3 & V2 Ethereum pools:

sDAI contract: 0x83F20F44975D03b1b09e64809B757c47f942BEeA

| Parameter | Value |
| --- | --- |
| wETH Optimal Ratio on V3 | from 80% to 90% |
| wETH slope 1 on V3 | from 4.8% to 3.8% |
| DAI RF on V2 | from 15% to 25% |
| DAI RF on V3 | from 10% to 20% |
| DAI optimal ratio on V3 | from 80% to 90% |
| DAI Slope1 on V3 | from 4% to 5% |
| DAI optimal ratio on V2 | from 80% to 90% |
| DAI Slope1 on V2 | from 4% to 5% |
| DAI stable Borrow | disabled on V2 |
| sDAI parameters | same as DAI but as collateral only |
| LTV | 77% |
| LT | 80% |
| Liquidation penalty | 4.5% |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230816_AaveV3_Eth_SDAIOnboarding/AaveV3_Ethereum_SDAIOnboarding_20230816.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230816_AaveV3_Eth_SDAIOnboarding/AaveV3_Ethereum_SDAIOnboarding_20230816.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb41600e3f74bfa520549106fee4d21e7f674c5a79fbf1f7ca16947563474a4d7)
- [Discussion](https://governance.aave.com/t/arfc-sdai-aave-v3-onboarding/14410)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
