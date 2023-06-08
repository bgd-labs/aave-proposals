## Reserve changes

### Reserves added

#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 900,000 LUSD |
| borrowCap | 900,000 LUSD |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF](https://arbiscan.io/address/0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF) |
| oracleDecimals | 8 |
| oracleDescription | LUSD / USD |
| oracleLatestAnswer | 1.01006432 |
| usageAsCollateralEnabled | false |
| ltv | 0 % |
| liquidationThreshold | 0 % |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % |
| reserveFactor | 10 % |
| aToken | [0x8Eb270e296023E9D92081fdF967dDd7878724424](https://arbiscan.io/address/0x8Eb270e296023E9D92081fdF967dDd7878724424) |
| aTokenImpl | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtToken | [0xCE186F6Cccb0c955445bb9d10C59caE488Fea559](https://arbiscan.io/address/0xCE186F6Cccb0c955445bb9d10C59caE488Fea559) |
| variableDebtTokenImpl | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtToken | [0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc](https://arbiscan.io/address/0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc) |
| stableDebtTokenImpl | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A](https://arbiscan.io/address/0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A) |
| aTokenName | Aave Arbitrum LUSD |
| aTokenSymbol | aArbLUSD |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt LUSD |
| stableDebtTokenSymbol | stableDebtArbLUSD |
| variableDebtTokenName | Aave Arbitrum Variable Debt LUSD |
| variableDebtTokenSymbol | variableDebtArbLUSD |
| optimalUsageRatio | 80 % |
| maxExcessUsageRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 87 % |
| baseStableBorrowRate | 5 % |
| stableRateSlope1 | 4 % |
| stableRateSlope2 | 87 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/43ce89e3d7fc2289843c17d09906ba45f0b42148.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "from": null,
      "to": {
        "aToken": "0x8Eb270e296023E9D92081fdF967dDd7878724424",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum LUSD",
        "aTokenSymbol": "aArbLUSD",
        "borrowCap": 900000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF",
        "oracleDecimals": 8,
        "oracleDescription": "LUSD / USD",
        "oracleLatestAnswer": 101006432,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt LUSD",
        "stableDebtTokenSymbol": "stableDebtArbLUSD",
        "supplyCap": 900000,
        "symbol": "LUSD",
        "underlying": "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0xCE186F6Cccb0c955445bb9d10C59caE488Fea559",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt LUSD",
        "variableDebtTokenSymbol": "variableDebtArbLUSD"
      }
    }
  },
  "strategies": {
    "0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "870000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "870000000000000000000000000"
      }
    }
  }
}
```