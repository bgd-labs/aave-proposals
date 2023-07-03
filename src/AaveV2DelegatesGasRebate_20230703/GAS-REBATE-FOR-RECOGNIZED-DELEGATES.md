---
title: Gas Rebate for Recognized Delegates
author: Marc Zeller (@marczeller), Aave-Chan initiative
discussions: https://governance.aave.com/t/arfc-gas-rebate-for-recognized-delegates/13290
---

## Simple Summary

This AIP propose to repay gas fees to recognized delegates who vote on-chain & deploy AIPs on Aave.

## Motivation

As Ethereum gas fees continue to rise, the cost of on-chain governance for delegates has proportionally increased.

This AIP proposes to repay gas fees to recognized delegates who vote on-chain & deploy AIPs on Aave.

Rebating delegates for their participation offers several benefits:
- Encourages more active engagement from the delegate community by eliminating the disincentive to vote, leading to better decision-making for Aave.
- Fosters a more diverse voter base, including student organizations, by reducing the barrier to entry for voting. This creates a more open and collaborative delegate ecosystem, driving participation.
- Helps retain top delegates to foster the growth of the Aave ecosystem. Aave should remain competitive with its peers (e.g., Maker) to attract and retain the best delegate talent. The fundamental cost of being an excellent Aave delegate should not result in a net cost to the delegate due to ever-increasing gas costs.
- Can be achieved at a relatively low cost. coverage of gas cost represent a small fraction of Aave protocol revenue.

## Specification

this AIP call `transfer()` on the Aave collector contract to transfer the gas fees to the delegate addresses.
while not complex this proposal payload is lenghty and to favor readability of this document, we invite the community willing to verify the payload code to refers to the references section link. 

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2DelegatesGasRebate_20230703/AaveV2EthBUSDIR_20230602Test.t.sol)
- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2DelegatesGasRebate_20230703/AaveV2DelegatesGasRebate_20230703.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
