---
title: Cancel Llama Streams
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-cancel-llama-service-provider-stream/14137
---

## Simple Summary

This ARFC proposes to cancel the Llama streams from the Aave DAO and create reduced rate streams

## Motivation

Llama has historically been a service provider for the Aave DAO and has made numerous contributions. However, during their tenure, there have been several instances where Llama’s performance has fallen short of expectations.

For instance:

Llama’s handling of the crucial CRV AIP was a clear demonstration of their inability to deliver a much-needed payload in a timely manner. The delay in execution resulted in an additional cost of approximately $1 million for the DAO due to the increased valuation of CRV. This incident underscores the need for service providers who can reliably deliver on their commitments and highlights Llama’s underqualification for the task at hand.
Despite receiving $1.5 million from the DAO, Llama charged third parties for consulting services related to Aave, including teams seeking asset listings.
As treasury managers, Llama failed to ensure that the collector contract had an adequate aUSDC balance. This oversight resulted in several service providers going unpaid for weeks, tarnishing the DAO’s brand and reputation.
Given these circumstances, we believe that the most beneficial course of action for the Aave DAO is to end our relationship with Llama. This will allow the DAO to reassess its needs and budget for a new service provider.

following snapshot vote decision, Llama will not be considered as a Service provider for the Aave DAO in the future and will finish its current engagement at a reduced stream 
The ACI and other service providers will complete any outstanding tasks from Llama’s engagement at no additional cost to the DAO.

## Specification

The AIP will call the cancelStream() method of the Ecosystem Reserve and Aave Collector contracts. once that is done, the AIP create two new reduced 57 Days streams. The details are as follows:

Ecosystem Reserve Contract: 0x25F2226B597E8F9514B3F68F00f494cF4f286491
Stream: 100001
Aave Collector Contract: 0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c
Stream: 100003
Address: 0xb428C6812E53F843185986472bb7c1E25632e0f7

## References

- Implementation: [Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3LlamaProposal_20230803/AaveV3LlamaProposal_20230803.sol)
- Tests: [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3LlamaProposal_20230803/AaveV3LlamaProposal_20230803_Test.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xceae27bbaf42658a1b46baec664c66c09f9cba4f9452ed2d2bed6f6ce5c66e35)
- [ARFC Discussion](https://governance.aave.com/t/arfc-cancel-llama-service-provider-stream/14137)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
