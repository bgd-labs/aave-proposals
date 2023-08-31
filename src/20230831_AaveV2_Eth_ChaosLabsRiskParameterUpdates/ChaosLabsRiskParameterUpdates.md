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

Implementing a gradual decrease in LTs effectively diminishes the borrowing power for the existing markets. This proposal offers the community two alternatives - a "moderate" and an "aggressive" approach for the preliminary LT reduction.

- Aggressive (Chaos Recommendation) - This option suggests an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of 8% from the closest LT figure, which would trigger more substantial liquidations.
- Moderate - If the community leans towards a more tempered approach of slowly reducing the Liquidation Thresholds, we propose limiting the LT decrease to a maximum of 10%. Hence, we define the “Moderate” option as the minimum between 10% and the value suggested by the aggressive approach.

• “Aggressive”

| Asset  | Current LT | Rec LT | Value Liquidated ($) | Accounts Liquidated |
| ------ | ---------- | ------ | -------------------- | ------------------- |
| BAL    | 55%        | 35%    | 1,580                | 5                   |
| BAT    | 52%        | 38%    | 750                  | 3                   |
| CVX    | 40%        | 34%    | 250                  | 3                   |
| DPI    | 42%        | 22%    | 80                   | 2                   |
| ENJ    | 60%        | 54%    | 500                  | 4                   |
| MANA   | 62%        | 54%    | 1,500                | 4                   |
| REN    | 40%        | 32%    | 1,160                | 3                   |
| xSUSHI | 60%        | 53%    | 0                    | 0                   |
| YFI    | 55%        | 52%    | 0                    | 0                   |
| ZRX    | 45%        | 39%    | 0                    | 0                   |
| LINK   | 83%        | 78%    | 2,440                | 10                  |
| 1INCH  | 50%        | 40%    | 56                   | 1                   |
| UNI    | 77%        | 57%    | 500                  | 9                   |
| SNX    | 59%        | 39%    | 650                  | 10                  |
| MKR    | 64%        | 44%    | 140                  | 5                   |
| ENS    | 57%        | 50%    | 45                   | 2                   |

• “Moderate”

| Asset  | Current LT | Rec LT | Value Liquidated ($) | Accounts Liquidated |
| ------ | ---------- | ------ | -------------------- | ------------------- |
| BAL    | 55%        | 45%    | 1,120                | 3                   |
| BAT    | 52%        | 42%    | 80                   | 2                   |
| CVX    | 40%        | 34%    | 250                  | 3                   |
| DPI    | 42%        | 32%    | 0                    | 0                   |
| ENJ    | 60%        | 54%    | 500                  | 4                   |
| MANA   | 62%        | 54%    | 1,500                | 4                   |
| REN    | 40%        | 32%    | 1,160                | 3                   |
| xSUSHI | 60%        | 53%    | 0                    | 0                   |
| YFI    | 55%        | 52%    | 0                    | 0                   |
| ZRX    | 45%        | 39%    | 0                    | 0                   |
| LINK   | 83%        | 78%    | 2,440                | 10                  |
| 1INCH  | 50%        | 40%    | 56                   | 1                   |
| UNI    | 77%        | 67%    | 290                  | 6                   |
| SNX    | 59%        | 49%    | 85                   | 3                   |
| MKR    | 64%        | 54%    | 16                   | 2                   |
| ENS    | 57%        | 50%    | 45                   | 2                   |

In the tables below, we share data to quantify the effect of the recommended reductions on protocol users:

|            | Value liquidated | Accounts liquidated |
| ---------- | ---------------- | ------------------- |
| Aggressive | $10,100          | 58                  |
| Moderate   | $8,580           | 43                  |

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
