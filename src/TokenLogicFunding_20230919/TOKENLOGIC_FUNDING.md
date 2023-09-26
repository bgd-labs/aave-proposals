---
title: TokenLogic Service Provider Proposal 
author: TokenLogic
discussions: https://governance.aave.com/t/arfc-tokenlogic-6-month-service-provider-proposal/14793 
---

# Summary

This AIP will onboard TokenLogic as a service provider to the Aave protocol.

# Motivation

TokenLogic has been contributing to Aave for nearly 6 months, and this publication formalizes our continued contribution to the Aave protocol by onboarding the team as a recognized service provider.

This funding will be used to support the TokenLogic team to deliver the scope as outlined in the [TEMP CHECK](https://snapshot.org/#/aave.eth/proposal/0x05636d75aae6e99be9c79a6337603f69213d34c3cf0b518842aa994f2ec790bf). Further details about the proposal can be found on the [ARFC](https://governance.aave.com/t/arfc-tokenlogic-6-month-service-provider-proposal/14793) forum post. 

# Specification

The following assets in the Treasury are to be swapped to GHO via the Aave Swap contract.

* [350,000 aethDAI](https://etherscan.io/token/0x018008bfb33d285247a21d44e50697654f754e63?a=0x464C71f6c2F760DdA6093dCB91C24c39e5d6e18c)

This AIP will call the createStream() method of the IAaveEcosystemReserveController interface to create a 180-day stream for 350,000 units of GHO.

The following address will be the recipient of the stream:

Address: `0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40`

TokenLogic will periodically claim a fraction of the budget for the duration of the stream.

# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-tokenlogic-6-month-service-provider-proposal/14793)
* [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x272af88d9639fd246943630d7ad053cea73db9d6b5bfeca222d9a8906991168b)
* [Test Cases](https://github.com/bgd-labs/aave-proposals/tree/main/src/TokenLogicFunding_20230919/TokenLogicFunding_20230919.t.sol)
* [Payload Implementation](https://github.com/bgd-labs/aave-proposals/tree/main/src/TokenLogicFunding_20230919/TokenLogicFunding_20230919.sol)
* [Deployed Contracts](https://etherscan.io/address/0xe5cac83f10f9eed3fe1575aee87de030815f1d83)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

TokenLogic receives payment from only Aave DAO for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
