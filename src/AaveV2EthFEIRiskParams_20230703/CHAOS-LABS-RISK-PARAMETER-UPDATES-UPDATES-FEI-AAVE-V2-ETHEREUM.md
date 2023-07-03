---
title: Chaos Labs Risk Parameter Updates - FEI on Aave V2 Ethereum
author: Chaos Labs (@ori-chaoslabs, @yonikesel)
discussions: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-fei-on-aave-v2-ethereum-2023-6-22/13782
---

## Simple Summary

A proposal to update four (4) risk parameters, including Liquidation Threshold (LT), Loan-To-Value (LTV), Liquidation Bonus (LB), and UOptimal for FEI on Aave V2 Ethereum.

## Motivation

As part of the ongoing risk mitigation strategies implemented for V2 Ethereum, this proposal suggests another series of risk parameter updates to minimize potential exposure to FEI. As a reminder, FEI has been frozen since [September 2022](https://app.aave.com/governance/proposal/96/), with the RF set at 99%.

Over the past months, we have witnessed a significant drop in market cap, and together with the recent price fluctuations, we recommend decreasing Aave’s FEI exposure to a minimum.

The recommended measures include the following:

1. Lowering LT and LTV to zero - This will prevent new borrowings against FEI and potentially further protocol losses should FEI's price fluctuate due to limited liquidity.
1. By reducing the LT to zero, two additional accounts will become eligible for liquidation, totaling a value of $1,051. The main account to be liquidated can be found [here](https://community.chaoslabs.xyz/aave-v2/ccar/wallets/0xa41f03dd427100284ecaa24734b00abc037557c0)
1. Raising the LB from 6.5% to 10% to provide a stronger incentive for liquidators to address underwater positions.
1. Decreasing the UOptimal from 80% to 1% to increase the borrowing rate and encourage borrowers to repay their loans.

## Specification

| Asset | Parameter | Current | Recommendation |
| ----- | --------- | ------- | -------------- |
| FEI   | LT        | 75%     | 1%\*           |
| FEI   | LTV       | 65%     | 0              |
| FEI   | LB        | 6.5%    | 10%            |
| FEI   | UOptimal  | 80%     | 1%             |

\*For technical reasons related to V2 we will set the LT 1% rather than at 0

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthFEIRiskParams_20230703/AaveV2EthFEIRiskParams_20230703Test.t.sol)
- [Payload](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthFEIRiskParams_20230703/AaveV2EthFEIRiskParams_20230703.sol)
