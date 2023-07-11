## Reserve changes

### Reserves added

#### GMX ([0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a](https://arbiscan.io/address/0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 110,000 GMX |
| borrowCap | 60,000 GMX |
| debtCeiling | 2,500,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xDB98056FecFff59D032aB628337A4887110df3dB](https://arbiscan.io/address/0xDB98056FecFff59D032aB628337A4887110df3dB) |
| oracleDecimals | 8 |
| oracleDescription | GMX / USD |
| oracleLatestAnswer | 55.40308053 |
| usageAsCollateralEnabled | true |
| ltv | 45 % |
| liquidationThreshold | 55 % |
| liquidationBonus | 8 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x6533afac2E7BCCB20dca161449A13A32D391fb00](https://arbiscan.io/address/0x6533afac2E7BCCB20dca161449A13A32D391fb00) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0x44705f578135cC5d703b4c9c122528C73Eb87145](https://arbiscan.io/address/0x44705f578135cC5d703b4c9c122528C73Eb87145) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtToken | [0x6B4b37618D85Db2a7b469983C888040F7F05Ea3D](https://arbiscan.io/address/0x6B4b37618D85Db2a7b469983C888040F7F05Ea3D) |
| stableDebtTokenImpl | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xD87974E8ED49AB16d5053ba793F4e17078Be0426](https://arbiscan.io/address/0xD87974E8ED49AB16d5053ba793F4e17078Be0426) |
| aTokenName | Aave Arbitrum GMX |
| aTokenSymbol | aArbGMX |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt GMX |
| stableDebtTokenSymbol | stableDebtArbGMX |
| variableDebtTokenName | Aave Arbitrum Variable Debt GMX |
| variableDebtTokenSymbol | variableDebtArbGMX |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 9 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/0f76438e7a6fd06d133234fe0cee6b3ef854250f.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a": {
      "from": null,
      "to": {
        "aToken": "0x6533afac2E7BCCB20dca161449A13A32D391fb00",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum GMX",
        "aTokenSymbol": "aArbGMX",
        "borrowCap": 60000,
        "borrowingEnabled": true,
        "debtCeiling": 250000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10800,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 5500,
        "ltv": 4500,
        "oracle": "0xDB98056FecFff59D032aB628337A4887110df3dB",
        "oracleDecimals": 8,
        "oracleDescription": "GMX / USD",
        "oracleLatestAnswer": 5540308053,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x6B4b37618D85Db2a7b469983C888040F7F05Ea3D",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt GMX",
        "stableDebtTokenSymbol": "stableDebtArbGMX",
        "supplyCap": 110000,
        "symbol": "GMX",
        "underlying": "0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x44705f578135cC5d703b4c9c122528C73Eb87145",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt GMX",
        "variableDebtTokenSymbol": "variableDebtArbGMX"
      }
    }
  },
  "strategies": {
    "0xD87974E8ED49AB16d5053ba793F4e17078Be0426": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "90000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "130000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "90000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```