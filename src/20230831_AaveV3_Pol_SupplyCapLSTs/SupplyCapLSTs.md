---
title: "SupplyCapLSTs"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-supply-cap-increase-lsts-on-polygon-v3/14696"
---

## Simple Summary
This proposal seeks to increase the supply cap for the wstETH and stMatic tokens on the AAVE Polygon V3 markets.

This proposal is compatible with the Direct-to-AIP framework.

## Motivation
On the AAVE Polygon V3 market, the utilization of the supply cap reached 95% for stMatic and 100% for the wstETH, preventing the deposit of more assets for the latter. By augmenting those caps we would be helping the ecosystems that have been built around those products and increasing the user experience of the AAVE users, resulting in higher TVL and protocol revenue through the borrowing of WMatic and WETH.

The total supplies of those assets increased recently, which allows the adjustement of those caps while staying below [75%](https://snapshot.org/#/aave.eth/proposal/0xf9261916c696ce2d793af41b7fe556896ed1ff7a8330b7d0489d5567ebefe3ba) of the total supplies.

## Specification
The following parameters would be modified for the stMatic and wstETH tokens:
| Token | Current supply cap | Proposed supply cap | Increase | Total Supply |	Total Supply (%) |
| --- | --- | --- | --- | --- | --- |
|stMatic Polygon V3 | 57M | 66M | ~16% | 88.9M | 75%|
|wstETH Polygon V3 | 3450 | 4125 | ~19% | 5.5k | 75%|

Contract:
* stMatic Polygon: 0x3a58a54c066fdc0f2d55fc9c89f0415c92ebf3c4
* wstETH Polygon: 0x03b54a6e9a984069379fae1a4fc4dbae93b3bccd

## References

- Implementation: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230831_AaveV3_Pol_SupplyCapLSTs/AaveV3_Polygon_SupplyCapLSTs_20230831.sol)
- Tests: [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230831_AaveV3_Pol_SupplyCapLSTs/AaveV3_Polygon_SupplyCapLSTs_20230831.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-supply-cap-increase-lsts-on-polygon-v3/14696)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).