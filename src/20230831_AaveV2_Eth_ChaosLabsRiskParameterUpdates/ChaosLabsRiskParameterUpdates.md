---
title: "Chaos Labs Risk Parameter Updates"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-08-09/14404"
---

## Simple Summary

A proposal to:

(1) Reduce the Liquidation Threshold (LT) and Loan-To-Value (LTV) for fourteen (14) frozen collateral assets on Aave V2 Ethereum.

(2) Increase Reserve Factors for collateral assets on Aave V2 Ethereum.

## Motivation

In line with our ongoing commitment to reducing the potential risks associated with V2 markets and promoting migration to V3, we suggest a phased wind-down of the **frozen** V2 markets. The following proposal is part of a series of proposals to reduce capital efficiency across V2 collateral assets.

The previous iteration of proposals:

- [[ARFC] Chaos Labs Risk Parameter Updates - Aave V2 Ethereum - 2023.6.23](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-6-23/13789)
- [[ARFC] Chaos Labs - Incremental Reserve Factor Updates - Aave V2 Ethereum](https://governance.aave.com/t/arfc-chaos-labs-incremental-reserve-factor-updates-aave-v2-ethereum/13766)

### LT Reductions

Implementing a gradual decrease in LTs effectively diminishes the borrowing power for the existing markets. The community has aligned on the aggressive option in the Snapshot, which suggested a LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. Following decline in the assets prices since the initial Snapshot, we have modified the proposal to be more conservative than the initially approved update. Please note LINK and DPI are omitted from this proposal, as reducing their LTs would put larger positions at risk of liquidation.

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

### LTV Decrease

For assets where the LTV is not 0, we recommend maintaining the same buffer as the current configuration.

### RF Increase

In line with our [V2 to V3 migration plan](https://governance.aave.com/t/temp-check-ethereum-v2-to-v3-migration/12636), we propose another iteration of RF increases on Aave V2 Ethereum. By progressively increasing the reserve factors, the interest rate for supplying these assets on V2 will be increasingly less attractive, thus encouraging suppliers to transition positions to V3. In this proposal, we suggest an increase of 5% for all V2 collateral assets.

## Specification

Frozen Assets:

| Asset  | Cur LT | Rec LT    | Current LTV | Rec LTV   | Current RF | Rec RF |
| ------ | ------ | --------- | ----------- | --------- | ---------- | ------ |
| BAL    | 55%    | 35%       | 0           | 0         | 30%        | 35%    |
| BAT    | 52%    | 40%       | 0           | 0         | 30%        | 35%    |
| CVX    | 40%    | 35%       | 0           | 0         | 30%        | 35%    |
| DPI    | 42%    | No Change | 0           | 0         | 30%        | 35%    |
| ENJ    | 60%    | 52%       | 0           | 0         | 30%        | 35%    |
| MANA   | 62%    | 54%       | 0           | 0         | 45%        | 50%    |
| REN    | 40%    | 32%       | 0           | 0         | 30%        | 35%    |
| xSUSHI | 60%    | 57%       | 0           | 0         | 45%        | 50%    |
| YFI    | 55%    | 50%       | 0           | 0         | 30%        | 35%    |
| ZRX    | 45%    | 42%       | 0           | 0         | 30%        | 35%    |
| LINK   | 83%    | No Change | 70%         | No Change | 25%        | 30%    |
| 1INCH  | 50%    | 40%       | 40%         | 30%       | 25%        | 30%    |
| UNI    | 77%    | 70%       | 65%         | 58%       | 25%        | 30%    |
| SNX    | 59%    | 49%       | 46%         | 36%       | 40%        | 45%    |
| MKR    | 64%    | 50%       | 59%         | 45%       | 25%        | 30%    |
| ENS    | 57%    | 52%       | 47%         | 42%       | 25%        | 30%    |

Unfrozen Assets

| Asset | Current RF | Recommended RF |
| ----- | ---------- | -------------- |
| FRAX  | 25%        | 30%            |
| GUSD  | 15%        | 20%            |
| LUSD  | 15%        | 20%            |
| sUSD  | 25%        | 30%            |
| USDC  | 15%        | 20%            |
| USDP  | 15%        | 20%            |
| USDT  | 15%        | 20%            |
| CRV   | 25%        | 30%            |
| WBTC  | 25%        | 30%            |
| ETH   | 20%        | 25%            |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230831_AaveV2_Eth_ChaosLabsRiskParameterUpdates/AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/20230831_AaveV2_Eth_ChaosLabsRiskParameterUpdates/AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc5786999ac6d574ca2fb3a3f169be0c38221d73613d4458afa87ab0251f4418a)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-08-09/14404)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
