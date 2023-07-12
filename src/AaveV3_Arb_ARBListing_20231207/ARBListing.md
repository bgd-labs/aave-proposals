---
title: add ARB to Aave V3 Arbitrum Pool
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-add-arb-to-arbitrum-aave-v3/13225
---

## Simple Summary

this AIP proposes to add ARB to the Aave V3 Arbitrum Pool

## Motivation

Adding support for ARB in Arbitrum v3 pools adds greater TVL and user experience to the increasingly popular Aave v3 Arbitrum market - and additional revenue opportunities for Aave.

By enabling borrowing, it allows users and institutions to take a unique position on this Governance token as the network matures and builds a decentralized community.

Furthermore, it more closely aligns the Aave community with Arbitrum and, by extension, Ethereum.

Additionally, it allows for creative uses of ARB received by the DAO to seed initial liquidity.

## Specification

Ticker: ARB

Contract Address: [0x912CE59144191C1204E64559FE8253a0e49E6548](https://arbiscan.io/address/0x912ce59144191c1204e64559fe8253a0e49e6548)`

### Risk Parameters

| Parameter                | Value    |
| ------------------------ | -------- |
| Isolation Mode           | Yes      |
| Borrowable               | Yes      |
| Collateral Enabled       | Yes      |
| Supply Cap (ARB)         | 20M      |
| Borrow Cap (ARB)         | 16.5M    |
| Debt Ceiling             | $14M     |
| LTV                      | 50.00%   |
| LT                       | 60.00%   |
| Liquidation Bonus        | 10.00%   |
| Liquidation Protocol Fee | 10.00%   |
| Reserve Factor           | 20.00%   |
| Variable Base            | 0.00%    |
| Variable Slope1          | 7.00%    |
| Variable Slope2          | 300.00%  |
| Uoptimal                 | 45%      |
| Stable Borrowing         | Disabled |

## References

- Implementation: [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Arb_ARBListing_20231207/AaveV3_Arb_ARBListing_20231207.sol)
- Tests: [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Arb_ARBListing_20231207/AaveV3_Arb_ARBListing_20231207.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x308439517ffc8faa8709db0b4a1d131d2402ee8a3282cb79adf890de6135ec98)
- [ARFC Discussion](https://governance.aave.com/t/arfc-add-arb-to-arbitrum-aave-v3/13225)
- [TEMP CHECK Discussion](https://governance.aave.com/t/temp-check-add-arb-to-arbitrum-aave-v3/12915)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
