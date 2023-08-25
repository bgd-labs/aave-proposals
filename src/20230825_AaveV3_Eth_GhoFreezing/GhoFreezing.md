---
title: "Gho Freezing"
author: "TBA"
discussions: "https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626"
---

## Simple Summary
This proposal softens the previously pause action of the GHO asset on Aave v3 Ethereum, by replacing that state with a freeze.

Additionally, RISK_ADMIN role is given to a `FreezingSteward` contract, allowing for the EMERGENCY_ADMIN role to freeze/unfreeze assets.

## Motivation

A technical issue has been identified in the GHO integration with the Aave V3 GHO pool and as a consequence, GHO as an asset has been temporarily paused by the Aave Guardian.

However, a freezing would have had the same effect, but the action was not available for the EMERGENCY_ADMIN role held by the Aave Guardian. So the freezing needs to be done by the Aave Governance.

## Specification

The proposal payload does the following:
1. Unpauses the GHO asset on Aave v3 Ethereum.
2. Freezes the GHO asset on Aave v3 Ethereum.
3. Gives RISK_ADMIN to a `FreezingSteward` smart contract, in order for any address with EMERGENCY_ADMIN role to be able to freeze/unfreeze.

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_Ethereum_GhoFreezing_20230825.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230825_AaveV3_Eth_GhoFreezing/AaveV3_Ethereum_GhoFreezing_20230825.t.sol)
- [Discussion](https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626)
- Freezing Steward: [TBA](TBA)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
