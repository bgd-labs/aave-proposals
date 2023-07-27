---
title: Set Metis Foundation Wallet as Emission Manager for METIS Token on Aave V3 Metis Pool
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-set-metis-foundation-wallet-as-emission-manager-for-metis-token-on-aave-v3-metis-pool/13912
---

## Simple Summary

This AIP proposes to set the Metis Foundation wallet as the emission manager for the METIS token on the Aave V3 Metis pool. This will enable the Metis Foundation to define and fund incentive programs for this Aave pool, promoting growth and expanding the user base of this new Aave V3 market.

## Motivation

The Metis Foundation has expressed a desire to actively contribute to the growth and development of the Aave V3 Metis pool. By setting their wallet as the emission manager for the METIS token, the Foundation will be able to directly fund incentive programs that can attract more users to the pool and stimulate activity. This aligns with the broader goals of the Aave community to foster active and engaged markets.

## Specification

The Metis Foundation wallet address is as follows:

Emission Admin Wallet (Metis Foundation): `0x97177cD80475f8b38945c1E77e12F0c9d50Ac84D`

The AIP calls the setEmissionAdmin() method in the emission_manager contract.

EMISSION_MANAGER.setEmissionAdmin(METIS, EMISSION_ADMIN);

This method will set the Metis Foundation wallet as the emission admin for the METIS token.

## References

- Implementation: [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Met_SetEmissionManager_20232607/AaveV3_Met_SetEmissionManager_20232607.sol)
- Tests: [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Met_SetEmissionManager_20232607/AaveV3_Met_SetEmissionManager_20232607.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xf34db3fe2401c061e822177856e55c9df34d065610c29d1ebac1513c3c8eb9ee)
- [Discussion](https://governance.aave.com/t/arfc-set-metis-foundation-wallet-as-emission-manager-for-metis-token-on-aave-v3-metis-pool/13912)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
