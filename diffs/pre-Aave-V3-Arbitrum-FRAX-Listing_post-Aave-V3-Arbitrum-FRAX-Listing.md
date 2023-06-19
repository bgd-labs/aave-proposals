## Reserve changes

### Reserves added

#### FRAX ([0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F](https://arbiscan.io/address/0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 7,000,000 FRAX |
| borrowCap | 5,500,000 FRAX |
| debtCeiling | 1,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8](https://arbiscan.io/address/0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8) |
| oracleDecimals | 8 |
| oracleDescription | FRAX / USD |
| oracleLatestAnswer | 0.9995476 |
| usageAsCollateralEnabled | true |
| ltv | 70 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 6 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0x8ffDf2DE812095b1D19CB146E4c004587C0A0692](https://arbiscan.io/address/0x8ffDf2DE812095b1D19CB146E4c004587C0A0692) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0xA8669021776Bc142DfcA87c21b4A52595bCbB40a](https://arbiscan.io/address/0xA8669021776Bc142DfcA87c21b4A52595bCbB40a) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://arbiscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0xa5e408678469d23efDB7694b1B0A85BB0669e8bd](https://arbiscan.io/address/0xa5e408678469d23efDB7694b1B0A85BB0669e8bd) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://arbiscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xA9F3C3caE095527061e6d270DBE163693e6fda9D](https://arbiscan.io/address/0xA9F3C3caE095527061e6d270DBE163693e6fda9D) |
| aTokenName | Aave Arbitrum FRAX |
| aTokenSymbol | aArbFRAX |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt FRAX |
| stableDebtTokenSymbol | stableDebtArbFRAX |
| variableDebtTokenName | Aave Arbitrum Variable Debt FRAX |
| variableDebtTokenSymbol | variableDebtArbFRAX |
| optimalUsageRatio | 80 % |
| maxExcessUsageRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 75 % |
| baseStableBorrowRate | 5 % |
| stableRateSlope1 | 0.5 % |
| stableRateSlope2 | 75 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/8d9de32bf30b1c9dcf71f07a13b228c69a71a4ce.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F": {
      "from": null,
      "to": {
        "aToken": "0x8ffDf2DE812095b1D19CB146E4c004587C0A0692",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "aTokenName": "Aave Arbitrum FRAX",
        "aTokenSymbol": "aArbFRAX",
        "borrowCap": 5500000,
        "borrowingEnabled": true,
        "debtCeiling": 100000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xA9F3C3caE095527061e6d270DBE163693e6fda9D",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10600,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7500,
        "ltv": 7000,
        "oracle": "0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8",
        "oracleDecimals": 8,
        "oracleDescription": "FRAX / USD",
        "oracleLatestAnswer": 99954760,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xa5e408678469d23efDB7694b1B0A85BB0669e8bd",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt FRAX",
        "stableDebtTokenSymbol": "stableDebtArbFRAX",
        "supplyCap": 7000000,
        "symbol": "FRAX",
        "underlying": "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xA8669021776Bc142DfcA87c21b4A52595bCbB40a",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt FRAX",
        "variableDebtTokenSymbol": "variableDebtArbFRAX"
      }
    }
  }
}
```