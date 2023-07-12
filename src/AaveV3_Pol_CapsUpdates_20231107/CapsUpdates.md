---
title: MaticX Polygon Supply Cap Update
author: Llama
discussions: https://governance.aave.com/t/arfc-polygon-supply-cap-update-07-07-2023/13928
---

## Simple Summary

This publication proposes increasing the MaticX Supply Cap on Polygon v3 from 38.0M units to 50.6M units.

## Motivation

The current Supply Cap’s utilisation is hovering around 87.9%, with 4.6M units of MaticX deposit capacity. Discussions with Stader Labs indicates a whale of approximately 10M-15M units is going to deposit on Aave v3. The current supply cap prohibites the full deposit and entering the yield maximising strategy.

With Liquidity Mining (LM) ongoing, MaticX deposit rewards (SD) and wMATIC borrowing rewards (stMATIC & MaticX), it is important that Aave DAO ensures there is adequate capacity to enable the yield maximising strategies to grow.

With an abundance of wMATIC deposits and LM ongoing, we are experiencing exception MaticX deposit growth.

To facilitate the continued growth of MaticX, this proposal seeks to increase the Supply Cap to 75% of supply on Polygon. This is the maximum counterparty risk Aave DAO has voted to support.

Current MaticX supply on Polygon is 67,440,058 units 1. Therefore the newly proposed Supply Cap is 50,600,000 units (rounded up).

With reference to the ARFC Aave V3 Caps update Framework and Direct to AIP Framework the preferred path forward is to implement several upgrades to gradually increase Aave’s MaticX exposure over time whilst bypassing Snapshot.

## Specification

Ticker: MaticX

Contract: polygon: 0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6 1

| Parameter | Current Value | Proposed Value |
| --------- | ------------- | -------------- |
| SupplyCap | 38M units     | 50.6M units    |

## References

- Implementation: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Pol_CapsUpdates_20231107/AaveV3_Pol_CapsUpdates_20231107.sol)
- Tests: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Pol_CapsUpdates_20231107/AaveV3_Pol_CapsUpdates_20231107.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-polygon-supply-cap-update-07-07-2023/13928)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
