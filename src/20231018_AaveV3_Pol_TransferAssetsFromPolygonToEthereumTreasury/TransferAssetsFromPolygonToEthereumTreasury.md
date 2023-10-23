---
title: "Transfer Assets From Polygon To Ethereum Treasury"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-transfer-assets-from-polygon-to-ethereum-treasury/15044"
---

## Simple Summary

This publication proposes transferring BAL, CRV, and USDC from the Polygon Treasury to the Ethereum Treasury.

## Motivation

Recently, the Aave DAO has created the [GHO Liquidity Committee](https://governance.aave.com/t/arfc-treasury-manage-gho-liquidity-committee/14914), completed an [AURA tokenswap with Olympus](https://governance.aave.com/t/arfc-treasury-management-acquire-aura/14683), and is also considering a [tokenswap with Aura Finance](https://snapshot.org/#/aave.eth/proposal/0x94735082d4ba33b53497efb025aa6dbf75a5e4ade71684fd675c03f0e416a294). Each of these proposals has already utilized or is likely to utilize stable coins held in the Ethereum Treasury:

406,000 DAI - GHO Liquidity Committee
420,159.28 DAI - Olympus DAO token swap
600,000 USDC - Acquire AURA OTC with Aura Finance & AEF
Total of 1,426,159.28 stable coins
This publication proposes transferring 1.5M DAI from Polygon to Ethereum to replenish the stable coin reserves.

Additionally, the Aave DAO’s BAL and CRV holdings will also be transferred from Polygon to Ethereum. These assets can then be integrated into the DAO’s broader strategy for managing these assets on Ethereum.

To implement this proposal, the newly released [Aave Polygon-Mainnet ERC20Bridge](https://governance.aave.com/t/update-on-aave-swapper-and-strategic-asset-manager-contracts/14522/3) by Llama will be utilized.

## Specification

Using the transfer the following assets from the Polygon to Ethereum Treasury.

- All BAL
- All CRV
- 1,500,000 DAI

## References

- Implementation: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/e069a04d94b64a982a0e625ec4197fcdcf58caf3/src/20231018_AaveV3_Pol_TransferAssetsFromPolygonToEthereumTreasury/AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018.sol)
- Tests: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/e069a04d94b64a982a0e625ec4197fcdcf58caf3/src/20231018_AaveV3_Pol_TransferAssetsFromPolygonToEthereumTreasury/AaveV3_Polygon_TransferAssetsFromPolygonToEthereumTreasury_20231018.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x33def6fd7bc3424fc47256ec0abdc3b75235d6f123dc1d15be7349066bc86319)
- [Discussion](https://governance.aave.com/t/arfc-transfer-assets-from-polygon-to-ethereum-treasury/15044)

## Disclaimer

TokenLogic receives no payment from beyond Aave protocol for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
