---
title: "Supply Cap increase - wstETH"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-supply-cap-increase-wsteth/14376/1"
---

## Simple Summary

This proposal seeks to increase the supply cap for the wstETH token on the following markets:
- Arbitrum V3
- Polygon V3
- Optimism V3

This proposal is compatible with the Direct-to-AIP framework.

## Motivation

On the Arbitrum V3, Optimism V3, and Polygon V3 markets, the utilization of the supply cap reached 77%, 90%, and 100% respectively. Augmenting those caps would allow for a higher TVL  resulting in a better experience for the user of Aave and the ecosystem built around the LSD yield leveraging. This would also increase protocol revenue via more borrowing of WETH on those diverse platforms.

Along with the utilization of the supply cap, the Total supply of this asset increased as well, which would allow the increase of those caps without compromising on the [75%](https://snapshot.org/#/aave.eth/proposal/0xf9261916c696ce2d793af41b7fe556896ed1ff7a8330b7d0489d5567ebefe3ba) of the total supply threshold.

## Specification

The following parameters would be modified for the wstETH token:

| Token | Current supply cap | Proposed supply cap | Increase | Total Supply | Total Supply (%) |
| --- | --- | --- | --- | --- | --- |
| wstETH Arbitrum V3 | 30k | 45k | 50% | 80k | 56.25% |
| wstETH Optimism V3 | 23k | 34.5k | 50% | 46k | 75% |
| wstETH Polygon V3 | 2.7k | 3.45k | ~28% | 4.6k | 75% |

Contract:
- wstETH Arbitrum: [0x5979d7b546e38e414f7e9822514be443a4800529](https://arbiscan.io/token/0x5979d7b546e38e414f7e9822514be443a4800529)
- wstETH Optimism: [0x1f32b1c2345538c0c6f582fcb022739c4a194ebb](https://optimistic.etherscan.io/token/0x1f32b1c2345538c0c6f582fcb022739c4a194ebb)
- wstETH Polygon: [0x03b54a6e9a984069379fae1a4fc4dbae93b3bccd](https://polygonscan.com/token/0x03b54a6e9a984069379fae1a4fc4dbae93b3bccd)

## References

- Implementation: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Opt_wstETH_CapsIncrease_20230908.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Arb_wstETH_CapsIncrease_20230908.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Pol_wstETH_CapsIncrease_20230908.sol)
- Tests: [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Opt_wstETH_CapsIncrease_20230908.t.sol), [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Arb_wstETH_CapsIncrease_20230908.t.sol), [Polygon](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Multi_wstETH_CapsIncrease_20230908/AaveV3_Pol_wstETH_CapsIncrease_20230908.t.sol)
- Snapshot: No snapshot for Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-supply-cap-increase-wsteth/14376/1)

## Disclaimer:

This AIP is powered by Skyward.
The author doesn’t possess wstETH tokens at the time of writing and isn’t compensated by LIDO for this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
