---
title: Upgrade Aave V3 ETH pool wETH parameters
author: Gauntlet, ACI
discussions: https://governance.aave.com/t/arfc-upgrade-aave-v3-eth-pool-weth-parameters/15110
---

## Summary

The current yields of stETH and reth are 3.30% and 3.07% respectively. By adjusting the slope1 parameter of WETH, we aim to:

- Enhance Profitability in Leverage Loops: The proposed adjustment will make leverage loops more profitable for users.
- Align with stETH and reth Yields: The proposed adjustment aims to set the slope1 slightly below the current yields of stETH and reth, ensuring Aave remains competitive.

Increased utilization of ETH reserve is expected to partly compensate for the slight loss of protocol revenue due to lower interest rate equilibrium.

## Specification

| Chain       | Asset | Current Uopt | Recommended Uopt | Current Variable Slope 1 | Recommended Variable Slope 1 |
| ----------- | ----- | ------------ | ---------------- | ------------------------ | ---------------------------- |
| Ethereum v3 | WETH  | 90%          | 80%              | 3.8%                     | 2.8%                         |

## Implementation

The proposal implements changes using the following payload:

- [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231024/AaveV3Ethereum_20231024.sol)

## References

- **Discussion**: https://governance.aave.com/t/arfc-upgrade-aave-v3-eth-pool-weth-parameters/15110

## Disclaimer

Gauntlet and ACI have not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
