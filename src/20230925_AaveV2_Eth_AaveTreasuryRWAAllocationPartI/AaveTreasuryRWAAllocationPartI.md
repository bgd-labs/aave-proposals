---
title: "Aave treasury RWA Allocation Part I"
author: "Marc Zeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790"
---

## Simple Summary

This proposal is the first part of the Aave treasury RWA allocation. It proposes to allocate 50k USDC & 500 AAVE to Centrifuge.

## Motivation

Aave has long been a contributor and supporter of RWA initiatives. Since the first announcement of GHO, the Aave community has consistently expressed its interest in expanding into this area. Treasury Management at Aave has historically been focused on strategic crypto assets, ignoring the returns and liquidity available in offchain markets for various reasons.

Today, with roughly 17% of the treasury in stablecoins (~13m USD), the Aave DAO is overlooking the 5% available interest in the risk-free rate of overnight financing of US treasury assets. This can offer $250,000 of recurring revenue a year at just 5m USD of investment. These markets can immediately become some of the highest earning revenue streams for the DAO.

Beyond just economics, this proposal would allow the Aave DAO to establish and begin developing the internal RWA expertise necessary to engage with these markets. Centrifuge Prime is purpose-built for DeFi native organizations, offering the critical services and infrastructure necessary to onboard a diverse portfolio of RWA through a single interface.

Centrifuge has a long track record of working with DAOs to bring RWA on as collateral, and pioneered the first Aave deployment into RWA with the joint development of the RWA Market. Onboarding Aave to Centrifuge Prime for liquid investment strategies is an optimal approach for scaling RWA with the Aave community. It will develop the legal and technical infrastructure necessary to interface with RWAs safely and efficiently, while allowing the Aave community to get comfortable and familiar with the processes and thinking around RWA. This will put Aave in a significantly improved position to be able to leverage RWA collateral for GHO in the long term, either to improve liquidity or develop additional revenue streams.

## Specification

This proposal withdraws 50k aUSDC from the Aave COLLECTOR contract and converts them to USDC before transferring them to the Centrifuge Treasury.
This proposal also create a 500 AAVE stream for a period of two years to the Centrifuge Treasury.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230925_AaveV2_Eth_AaveTreasuryRWAAllocationPartI/AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230925_AaveV2_Eth_AaveTreasuryRWAAllocationPartI/AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0)
- [Discussion](https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
