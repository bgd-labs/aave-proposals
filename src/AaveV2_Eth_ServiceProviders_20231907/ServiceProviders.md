---
title: Acquire more aUSDC to pay service providers
author: Llama
discussions: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
---

## Simple Summary

Aave DAO's service provider aUSDC burn rate exceeds the aUSDC revenue. Consequently, assets held in the Ethereum Collector Contract need to be periodically swapped to USDC and deposited in Aave v2.

This publication intends to swap several assets via Cowswap to USDC. The USDC is to be deposited in Aave v2 for aUSDC and then used to remunerate Service Providers via the various streaming contracts.

## Motivation

There are a number of Service Providers requiring payment in aUSDC. Details of each Service Providers funding can be found [here](https://community.llama.xyz/aave/runway) by hovering the cursor over the respective Service Providers contract. Similar applies for the contract start and finish dates.

In order to provide sufficient funding, assets need to be converted to aUSDC. This publication proposes swapping assets to USDC and then depositing the USDC into Aave v2. The amount of aUSDC held post swap is estimated to be $4.5M which is sufficient to sustain the DAO in the short term.

During the next 6 months several Service Providers funding will expire and require re-approval from the DAO. Llama anticipates Service Providers migrating from aUSDC to aethUSDC. ie: from v2 to v3 aToken funding. Our next proposal will include transferring funds from Aave v2 to v3 which is an enabler for new funding requests to use aethTokens.

## Specification

Perform the following:

- Deposit USDC in Collector into aUSDC v2
- Swap 974,000 aUSDT v2 for aUSDC v2
- Swap 974,000 aDAI v2 for aUSDC v2

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_ServiceProviders_20231907/AaveV3_Eth_ServiceProviders_20231907.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_ServiceProviders_20231907/AaveV3_Eth_ServiceProviders_20231907.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083)
- [Discussion](https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
