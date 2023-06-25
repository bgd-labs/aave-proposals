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
| oracleLatestAnswer | 0.99913768 |
| usageAsCollateralEnabled | true |
| ltv | 70 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 6 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0x724dc807b04555b71ed48a6896b6F41593b8C637](https://arbiscan.io/address/0x724dc807b04555b71ed48a6896b6F41593b8C637) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6](https://arbiscan.io/address/0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtToken | [0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a](https://arbiscan.io/address/0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a) |
| stableDebtTokenImpl | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
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
        "aToken": "0x724dc807b04555b71ed48a6896b6F41593b8C637",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
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
        "oracleLatestAnswer": 99913768,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt FRAX",
        "stableDebtTokenSymbol": "stableDebtArbFRAX",
        "supplyCap": 7000000,
        "symbol": "FRAX",
        "underlying": "0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt FRAX",
        "variableDebtTokenSymbol": "variableDebtArbFRAX"
      }
    }
  }
}
```