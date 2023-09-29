---
title: Treasury Management - Create AGD GHO Allowance
discussions: https://governance.aave.com/t/arfc-treasury-management-replace-agd-s-dai-allowance-with-gho-allowance/14631
author: TokenLogic
---

# Summary

This AIP will replace Aave Grants DAO’s (AGD) DAI allowance with a GHO allowance.

# Motivation

Upon implementation of this proposal, AGD contributors and grant recipients are to be rewarded with GHO, and any other asset held in the AGD’s multisig.

Given that GHO is currently trading below $1, the Aave DAO can purchase GHO from the market and use it to fund AGD. This is expected to help support the GH peg whilst also promoting the usage and adoption of GHO.

By implementing this proposal the Aave DAO is sending a strong signal of support for GHO by using it to reward contributors to the community.

# Specification

The following assets from the Treasury are to be swapped to GHO using the Aave Swap Contract:

- 228,000 units of aEthUSDC
- 150,000 units of aEthUSDT

GHO is to be transferred to the Treasury.

The following Ethereum Treasury allowances are to be amended:

- Cancel aDAI Allowance
- Create GHO Allowance (388,000 units)

The AGD mulisig `eth:0x89C51828427F70D77875C6747759fB17Ba10Ceb0` will be able to use the allowance function on `0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c` to claim the GHO.

# Implementation

A list of relevant links like for this proposal:

- [Governance Forum Discussion](https://governance.aave.com/t/arfc-treasury-management-replace-agd-s-dai-allowance-with-gho-allowance/14631)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x53728c0416a9063bf833f90c3b3169fa4387e66549d5eb2b7ed2747bfe7c23fc)
- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/da71e84ff0ed0cad7d8c05520c7c76b77e9ddaf1/src/AgdAllowanceModification_20230817/AgdAllowanceModification_20230817.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/da71e84ff0ed0cad7d8c05520c7c76b77e9ddaf1/src/AgdAllowanceModification_20230817/AgdAllowanceModification_20230817.sol)
- [Deployed Contracts](https://etherscan.io/address/0x7fba17da9a96fb77a86229c975c91ded11dafa60)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclosure

TokenLogic receives no payment from the Aave DAO or any external source for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
