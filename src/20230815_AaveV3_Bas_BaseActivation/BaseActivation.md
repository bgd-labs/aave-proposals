---
title: "Aave v3 Base Activation"
author: "BGD labs"
discussions: https://governance.aave.com/t/arfc-aave-v3-deployment-on-base/13708
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 Base pool (3.0.2) by completing all the initial setup and listing WETH, USDbC and cbETH as suggested by the risk service providers (Gauntlet and Chaos Labs) on the [governance forum](https://governance.aave.com/t/arfc-aave-v3-deployment-on-base/13708/10). All the Aave Base V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3Base.sol).

## Motivation

The Base and Coinbase ecosystem is a good opportunity of expansion for Aave, touching into the new user base and exploring fresh use cases.

Aave community has approved the expansion on the [governance forum](https://governance.aave.com/t/arfc-aave-v3-deployment-on-base/13708) and [snapshot](https://snapshot.org/#/aave.eth/proposal/0xa8b018962096aa1fc22446a395d4298ebb6ca10094f35d072fbb02048e3b5eab).

## Specification

The proposal will do the following:

- set risk steward as the risk admin by executing `ACL_MANAGER.addRiskAdmin()`
- set price oracle sentinel with `POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel()`
- list the following assets on Aave V3 on Base: wETH, cbETH, and USDbC.

The table below illustrates the initial suggested risk parameters for each asset, a combination of recommendations provided by Gauntlet and ChaosLabs.

|                          | WETH           | USDbC     | cbETH          |
| ------------------------ | -------------- | --------- | -------------- |
| Isolation Mode           | NO             | NO        | NO             |
| Enable Borrow            | YES            | YES       | YES            |
| Enable Collateral        | YES            | YES       | YES            |
| Emode Category           | eth-correlated | N/A       | eth-correlated |
| Loan To Value            | 80%            | 77%       | 67%            |
| Liquidation Threshold    | 83%            | 80%       | 74%            |
| Liquidation Bonus        | 5%             | 5%        | 7.5%           |
| Reserve Factor           | 15%            | 10%       | 15%            |
| Liquidation Protocol Fee | 10%            | 10%       | 10%            |
| Supply Cap               | 5,000          | 8,000,000 | 1,000          |
| Borrow Cap               | 4,000          | 6,500,000 | 100            |
| Debt Ceiling             | N/A            | N/A       | N/A            |
| uOptimal                 | 80%            | 90%       | 45%            |
| Base                     | 0%             | 0%        | 0%             |
| Slope1                   | 3.8%           | 4%        | 7%             |
| Slope2                   | 80%            | 60%       | 300%           |
| Stable Borrowing         | Disabled       | Disabled  | Disabled       |
| Flashloanable            | YES            | YES       | YES            |
| Siloed Borrowing         | NO             | NO        | NO             |
| Borrowed in Isolation    | NO             | YES       | NO             |

**E-Mode:**

| Category       | Assets included | LT  | LTV | Liquidation Bonus |
| -------------- | --------------- | --- | --- | ----------------- |
| eth-correlated | WETH, cbETH     | 93% | 90% | 2%                |

cbEth adapter: [0x80f2c02224a2E548FC67c0bF705eBFA825dd5439](https://basescan.org/address/0x80f2c02224a2e548fc67c0bf705ebfa825dd5439)

Price oracle sentinel: [0xe34949A48cd2E6f5CD41753e449bd2d43993C9AC](https://basescan.org/address/0xe34949A48cd2E6f5CD41753e449bd2d43993C9AC)

Risk Steward: [0x12DEB4025b79f2B43f6aeF079F9D77C3f9a67bb6](https://basescan.org/address/0x12DEB4025b79f2B43f6aeF079F9D77C3f9a67bb6)

## Security

The proposal execution is simulated within the [tests](https://github.com/bgd-labs/aave-v3-basenet-proposal/blob/main/tests/AaveV3_BaseActivation.t.sol) and the resulting pool configuration is tested for correctness.

The deployed pool and other permissions have been programmatically verified.

In addition, we have also checked the code diffs of the deployed base contracts with the deployed contracts on Ethereum and other networks.

As a matter of caution, the POOL_ADMIN role will be given for the first weeks to the Aave Guardian multisig.

## References

- Implementation: [Base](https://github.com/bgd-labs/aave-v3-basenet-proposal/blob/main/src/contracts/AaveV3_BaseActivation.sol)
- Tests: [Base](https://github.com/bgd-labs/aave-v3-basenet-proposal/blob/main/tests/AaveV3_BaseActivation.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xa8b018962096aa1fc22446a395d4298ebb6ca10094f35d072fbb02048e3b5eab)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-base/13708)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
