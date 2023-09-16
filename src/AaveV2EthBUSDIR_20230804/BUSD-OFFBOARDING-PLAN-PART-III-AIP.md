---
title: BUSD Offboarding Plan Part III
author: Marc Zeller (@marczeller), Aave-Chan initiative
discussions: https://governance.aave.com/t/arfc-busd-offboarding-plan-part-iii/14136
---

## Simple Summary

This ARFC proposal outlines the third part of the offboarding plan for BUSD on the Aave V2 Ethereum market. The plan aims to further reduce the amount of liquidity in BUSD and encourage users to switch to other stablecoins. The plan involves modification of BUSD risk parameters and withdrawal of aBUSD from the collector contract.

## Motivation

Please refer to the first and second parts of the BUSD offboarding plan for more context. The first two parts of the plan were successful, driving out liquidity and incentivizing active users to repay their debt and move their position to other stablecoins. The remaining vBUSD debt holders seem to be inactive or unaffected by high rates, due to the time-sensitive nature of BUSD/Paxos situation and the potential risk of protocol bad debt.

This third part of the offboarding plan will concentrate efforts on creating unsustainable positions for remaining borrowers to either motivate them enough to repay or reach liquidation thresholds.

Both actions are proposed to be performed:

- Modify risk parameters to “increase” Base interest rate and slope1 curve aggressiveness while decreasing the uOptimal parameter.
- Remove aBUSD from the collector contract to increase the utilization ratio of BUSD and increase the cost of open positions.

## Specification

Ticker: BUSD (BUSD)

Contract Address: 0x4Fabb145d64652a948d72533023f6E7A623C7C53

The offboarding plan will be carried out With the current AIP with the following parameters:

- Decrease uOptimal from 2% to 1%.
- reserveFactor remains unchanged at 99.9%.
- base rate increase from 3 to 100%.
- slope 1 increase from 7 to 70%.
- slope 2 remains unchanged at 300%.

Withdrawal of aBUSD from the collector contract. The BUSD will be kept as such in the collector contract, and a separate AIP will organize the swap of BUSD into other assets at a later stage.

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthBUSDIR_20230804/AaveV2EthBUSDIR_20230602Test.t.sol)
- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
