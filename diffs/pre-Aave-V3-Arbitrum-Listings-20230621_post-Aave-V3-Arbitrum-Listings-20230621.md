## Reserve changes

### Reserves added

#### USDC ([0xaf88d065e77c8cC2239327C5EDb3A432268e5831](https://arbiscan.io/address/0xaf88d065e77c8cC2239327C5EDb3A432268e5831))

| description | value |
| --- | --- |
| decimals | 6 |
| isActive | true |
| isFrozen | false |
| supplyCap | 41,000,000 USDC |
| borrowCap | 41,000,000 USDC |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 1 |
| oracle | [0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3](https://arbiscan.io/address/0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3) |
| oracleDecimals | 8 |
| oracleDescription | USDC / USD |
| oracleLatestAnswer | 1.0001 |
| usageAsCollateralEnabled | true |
| ltv | 81 % |
| liquidationThreshold | 86 % |
| liquidationBonus | 5 % |
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
| isBorrowableInIsolation | true |
| interestRateStrategy | [0xf6733B9842883BFE0e0a940eA2F572676af31bde](https://arbiscan.io/address/0xf6733B9842883BFE0e0a940eA2F572676af31bde) |
| aTokenName | Aave Arbitrum USDCn |
| aTokenSymbol | aArbUSDCn |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt USDCn |
| stableDebtTokenSymbol | stableDebtArbUSDCn |
| variableDebtTokenName | Aave Arbitrum Variable Debt USDCn |
| variableDebtTokenSymbol | variableDebtArbUSDCn |
| optimalUsageRatio | 90 % |
| maxExcessUsageRatio | 10 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 3.5 % |
| variableRateSlope2 | 60 % |
| baseStableBorrowRate | 4.5 % |
| stableRateSlope1 | 5 % |
| stableRateSlope2 | 60 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/26fe9d5b1f609d3f149edb1d9d48db7c8ef3a63d.svg) |
| eMode.label | Stablecoins |
| eMode.ltv | 93 % |
| eMode.liquidationThreshold | 95 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0xaf88d065e77c8cC2239327C5EDb3A432268e5831": {
      "from": null,
      "to": {
        "aToken": "0x724dc807b04555b71ed48a6896b6F41593b8C637",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum USDCn",
        "aTokenSymbol": "aArbUSDCn",
        "borrowCap": 41000000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 6,
        "eModeCategory": 1,
        "interestRateStrategy": "0xf6733B9842883BFE0e0a940eA2F572676af31bde",
        "isActive": true,
        "isBorrowableInIsolation": true,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 8600,
        "ltv": 8100,
        "oracle": "0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3",
        "oracleDecimals": 8,
        "oracleDescription": "USDC / USD",
        "oracleLatestAnswer": 100010000,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt USDCn",
        "stableDebtTokenSymbol": "stableDebtArbUSDCn",
        "supplyCap": 41000000,
        "symbol": "USDC",
        "underlying": "0xaf88d065e77c8cC2239327C5EDb3A432268e5831",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt USDCn",
        "variableDebtTokenSymbol": "variableDebtArbUSDCn"
      }
    }
  },
  "strategies": {
    "0xf6733B9842883BFE0e0a940eA2F572676af31bde": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "45000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "50000000000000000000000000",
        "stableRateSlope2": "600000000000000000000000000",
        "variableRateSlope1": "35000000000000000000000000",
        "variableRateSlope2": "600000000000000000000000000"
      }
    }
  }
}
```