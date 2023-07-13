## Reserve changes

### Reserves added

#### ARB ([0x912CE59144191C1204E64559FE8253a0e49E6548](https://arbiscan.io/address/0x912CE59144191C1204E64559FE8253a0e49E6548))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 20,000,000 ARB |
| borrowCap | 16,500,000 ARB |
| debtCeiling | 14,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6](https://arbiscan.io/address/0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6) |
| oracleDecimals | 8 |
| oracleDescription | ARB / USD |
| oracleLatestAnswer | 1.12783 |
| usageAsCollateralEnabled | true |
| ltv | 50 % |
| liquidationThreshold | 60 % |
| liquidationBonus | 10 % |
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
| aTokenName | Aave Arbitrum ARB |
| aTokenSymbol | aArbARB |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt ARB |
| stableDebtTokenSymbol | stableDebtArbARB |
| variableDebtTokenName | Aave Arbitrum Variable Debt ARB |
| variableDebtTokenSymbol | variableDebtArbARB |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 8 % |
| stableRateSlope1 | 7 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/11fa722c8174e6a8b33a6ba1b49f3d0138f692a3.svg) |


## Raw diff

```json
{
  "reserves": {
    "0x912CE59144191C1204E64559FE8253a0e49E6548": {
      "from": null,
      "to": {
        "aToken": "0x6533afac2E7BCCB20dca161449A13A32D391fb00",
        "aTokenImpl": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a",
        "aTokenName": "Aave Arbitrum ARB",
        "aTokenSymbol": "aArbARB",
        "borrowCap": 16500000,
        "borrowingEnabled": true,
        "debtCeiling": 1400000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 6000,
        "ltv": 5000,
        "oracle": "0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6",
        "oracleDecimals": 8,
        "oracleDescription": "ARB / USD",
        "oracleLatestAnswer": 112783000,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x6B4b37618D85Db2a7b469983C888040F7F05Ea3D",
        "stableDebtTokenImpl": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt ARB",
        "stableDebtTokenSymbol": "stableDebtArbARB",
        "supplyCap": 20000000,
        "symbol": "ARB",
        "underlying": "0x912CE59144191C1204E64559FE8253a0e49E6548",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x44705f578135cC5d703b4c9c122528C73Eb87145",
        "variableDebtTokenImpl": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt ARB",
        "variableDebtTokenSymbol": "variableDebtArbARB"
      }
    }
  },
  "strategies": {
    "0xD87974E8ED49AB16d5053ba793F4e17078Be0426": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "80000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```