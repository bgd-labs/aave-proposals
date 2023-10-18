---
title: "Futher Increase GHO Borrow Rate"
author: "Marc Zeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-further-increase-gho-borrow-rate/15053"
---

## Simple Summary

This ARFC proposes a further increase in the GHO borrow rate by 50 basis points (bps), raising it from 2.5% to 3%.

## Motivation

The Aave community has previously recognized the importance of adjusting the GHO borrow rate to maintain the stability and health of the protocol. The motivations for this proposal are:

1. **Strengthening the GHO Peg**: The prior adjustment to the GHO borrow rate resulted in a stronger GHO peg. An additional increase is anticipated to further bolster the peg and get closer to the target value.
2. **Enhancing GHO Revenue**: By increasing the borrow rate, the protocol is expected to generate additional revenue from GHO borrowings.
3. **Coordinated Effort**: This proposal aligns with other initiatives, including the GHO buy program set of AIPs, as part of a coordinated effort to support the GHO peg.

The discount for stkAave holders remains unchanged at 30%.

This proposal also greenlights the ACI for a `direct-to-AIP` process for 50 bps increments every 30 days, as long as the GHO peg is outside 0,995<>1,005 monthly average price range, up to 5.5% borrow rate. 

## Specification

- Asset: GHO  
- Contract Address: 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f  
- Current Borrow Rate: 2.5%  
- Proposed Borrow Rate: 3%  
- New discounted Borrow Rate: ~2.1%

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/8d8b2f2385fbfa2ae29c2de814edeba907d54073/src/20231015_AaveV3_Eth_FutherIncreaseGHOBorrowRate/AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/8d8b2f2385fbfa2ae29c2de814edeba907d54073/src/20231015_AaveV3_Eth_FutherIncreaseGHOBorrowRate/AaveV3_Ethereum_FutherIncreaseGHOBorrowRate_20231015.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x25557cd27107c25e5bd55f7e23af7665d16eba3ad8325f4dc5cc8ade9b7c6d1f)
- [Discussion](https://governance.aave.com/t/arfc-further-increase-gho-borrow-rate/15053)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
