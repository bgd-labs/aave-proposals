---
title: "Freeze Stewards"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626/8"
---

## Simple Summary
As the Aave V3 Ethereum pool already has a freezing steward, which allows the emergency admin to freeze reserves, this AIP aims to synchronize the behavior by doing the same across networks. 

## Motivation
In order to maintain security across Aave V3 deployments, it's essential to maintain up-to-date preventative functionality on all networks.

## Specification
Adds a `FreezingSteward` as the `riskAdmin` on the canonical Aave V3 deployments on the following networks:

- Optimism
- Arbitrum
- Polygon
- Metis
- Base

The `FreezingSteward` is identical to the one currently [deployed on Ethereum](https://etherscan.io/address/0x2eE68ACb6A1319de1b49DC139894644E424fefD6#code), and only allows the `emergencyAdmin` listed in the `ACLManager` for the given deployment to freeze reserves.

This proposal also acts as an approval for the Guardian to execute the payload on the Avalanche network.

## References

- Implementation: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Optimism_FreezeStewards_20230907.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Arbitrum_FreezeStewards_20230907.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Polygon_FreezeStewards_20230907.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.sol), [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.sol), [Base](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.sol)
- Tests: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Optimism_FreezeStewards_20230907.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Arbitrum_FreezeStewards_20230907.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Polygon_FreezeStewards_20230907.t.sol), [Avalanche](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.t.sol), [Metis](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.t.sol), [Base](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.t.sol)
- [Discussion](https://governance.aave.com/t/temporarily-pausing-gho-integration-in-aave/14626/8)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
