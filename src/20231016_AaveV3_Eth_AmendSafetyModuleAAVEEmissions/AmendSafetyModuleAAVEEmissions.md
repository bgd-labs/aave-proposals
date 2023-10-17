---
title: "Amend Safety Module AAVE Emissions"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-treasury-management-amend-safety-module-aave-emissions/14936"
---

## Simple Summary

This publication proposes reducing AAVE (Safety Incentives) distributions to the Safety Module (SM) by 30% and introducing a 90-day SM emission cycle.

## Motivation

The SM serves as the Aave Protocol’s self-protection smart contract. The Aave Protocol distributes 1,100 AAVE daily, split evenly across AAVE and B-80AAVE-20wETH deposits.

Future proposals shall discuss the composition and aim to improve the overall capital efficiency of the SM. However, this publication intends to reduce AAVE emissions in the immediate future, saving the DAO valuable AAVE emissions while the broader SM upgrade is being advanced. It is widely accepted within the community that Aave DAO is overpaying for AAVE and B-80BAL-20wETH deposits.

This publication proposes reducing AAVE emissions by ~30%. The revised AAVE emission is to be reduced from 1,100 AAVE/day to 770 AAVE/day. This represents a 330 AAVE/day reduction. The APR for stkAAVE holders is expected to reduce from 6.87% to 4.81%. Similarly, for the B-80BAL-20wETH deposits, yield is expected to fall from 14.35% to 10.05%.

Please note that the 80AAVE/20wETH Balancer v1 pool is to be migrated to Balancer v2 in the future. This will present the community with an opportunity to further revise the AAVE emissions. It may also occur at a time when the DAO has vlAURA and/or veBAL at its disposal.

For context, the Llama Part IV SM Upgrade suggests reducing the AAVE emission to stkAAVE holders by 75%. This is because slashing for stkAAVE is to be reduced, additional assets are to be added to the SM, and the emissions are to be redirected to those newly added assets. Since this proposal was published, stkAAVE has also gained the utility of discounted GHO borrowing rates.

Similarly, Xenophon Labs recommended doubling the slashing percentage from 30% to 60% on the stkAAVE pool and lowering emissions by 80 AAVE/day, from 550 to 470. While this publication does not propose amending the slashing rate, the reduction in AAVE emissions is about double.

## Specification

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231016_AaveV3_Eth_AmendSafetyModuleAAVEEmissions/AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20231016_AaveV3_Eth_AmendSafetyModuleAAVEEmissions/AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb0124fb0206676ee743e8d6221b7b3c317cb26a657551f11cb5fa23544772a73)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-amend-safety-module-aave-emissions/14936)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
