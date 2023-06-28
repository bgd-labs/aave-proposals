---
title: Chaos Labs - Payment Collection Request
discussions: https://governance.aave.com/t/arfc-chaos-labs-payment-collection-request/13792
author: ChaosLabs (yonikesel, ori-chaoslabs)
---

# Summary

Chaos Labs requests the collection of a $350,000 delivery-based payment, as approved by the DAO in our service provider [proposal](https://governance.aave.com/t/updated-proposal-chaos-labs-risk-simulation-platform/10025).

# Motivation

The payment structure for Chaos’ initial engagement with Aave, starting in November 2022, amounts to a total of $850,000, divided into:

- $500,000 base fee, paid in USDC and streamed linearly over the course of the contract
- $350,000, to be paid in AAVE tokens and contingent on the delivery of Chaos’ products:
  - $175,000 paid in AAVE tokens payable upon delivery of the Aave Parameter Recommendations Tools (7-day TWAP)
  - $175,000 paid in AAVE tokens payable upon delivery of the Aave Asset Listing Portal (7-day TWAP)

Upon completion and delivery of these deliverables, and in consideration of our ongoing work and services rendered to the DAO, we kindly request the delivery of the delivery-based payment.

Resources:

- [Chaos Labs Parameter Recommendation Platform](https://governance.aave.com/t/chaos-labs-parameter-recommendation-platform/11537)
- [[Blog] Chaos Labs Launches Aave Parameter Recommendation Platform](https://chaoslabs.xyz/posts/chaos-labs-aave-recommendations)
- [Chaos Labs Asset Listing Portal](https://governance.aave.com/t/chaos-labs-asset-listing-portal/13064)
- [[Blog] Chaos Labs Launches Aave Asset Listing Portal](https://chaoslabs.xyz/posts/chaos-labs-launches-the-aave-asset-listing-portal-to-streamline-new-collateral-onboarding)
- [Platform](https://community.chaoslabs.xyz/aave/recommendations)

# Specification

A one-time transfer amounting to 6,541 $AAVE ($350,000 using 7-day TWAP, $53.50, calculated on 06.23.2023) will be made to a Chaos Labs-controlled account (0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0) as the recipient.

In terms of technical implementation, the AIP will call the transfer() method of the IAaveEcosystemReserveController interface to create a payment of 6,541 $AAVE.

# Implementation

A list of relevant links like for this proposal:

- [Test Cases](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ChaosLabsPaymentCollection_20230626/AaveV3ChaosLabsPaymentCollection_20230626Test.t.sol)
- [Payload Implementation](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3ChaosLabsPaymentCollection_20230626/AaveV3ChaosLabsPaymentCollection_20230626.sol)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
