## Reserve changes

### Reserves added

#### 1INCH ([0x111111111117dC0aa78b770fA6A738034120C302](https://etherscan.io/address/0x111111111117dC0aa78b770fA6A738034120C302))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 22,000,000 1INCH |
| borrowCap | 720,000 1INCH |
| debtCeiling | 4,500,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xc929ad75B72593967DE83E7F7Cda0493458261D9](https://etherscan.io/address/0xc929ad75B72593967DE83E7F7Cda0493458261D9) |
| oracleDecimals | 8 |
| oracleDescription | 1INCH / USD |
| oracleLatestAnswer | 0.41287589 |
| usageAsCollateralEnabled | true |
| ltv | 57 % |
| liquidationThreshold | 67 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e](https://etherscan.io/address/0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0xd180D7fdD4092f07428eFE801E17BC03576b3192](https://etherscan.io/address/0xd180D7fdD4092f07428eFE801E17BC03576b3192) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347](https://etherscan.io/address/0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x8F183Ee74C790CB558232a141099b316D6C8Ba6E](https://etherscan.io/address/0x8F183Ee74C790CB558232a141099b316D6C8Ba6E) |
| aTokenName | Aave Ethereum 1INCH |
| aTokenSymbol | aEth1INCH |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt 1INCH |
| stableDebtTokenSymbol | stableDebtEth1INCH |
| variableDebtTokenName | Aave Ethereum Variable Debt 1INCH |
| variableDebtTokenSymbol | variableDebtEth1INCH |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 9 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 12 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/12accf0fd189bd0ec8f5f33b46f04aa39ddfe4c0.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x111111111117dC0aa78b770fA6A738034120C302": {
      "from": null,
      "to": {
        "aToken": "0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum 1INCH",
        "aTokenSymbol": "aEth1INCH",
        "borrowCap": 720000,
        "borrowingEnabled": true,
        "debtCeiling": 450000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x8F183Ee74C790CB558232a141099b316D6C8Ba6E",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 6700,
        "ltv": 5700,
        "oracle": "0xc929ad75B72593967DE83E7F7Cda0493458261D9",
        "oracleDecimals": 8,
        "oracleDescription": "1INCH / USD",
        "oracleLatestAnswer": 41287589,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt 1INCH",
        "stableDebtTokenSymbol": "stableDebtEth1INCH",
        "supplyCap": 22000000,
        "symbol": "1INCH",
        "underlying": "0x111111111117dC0aa78b770fA6A738034120C302",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xd180D7fdD4092f07428eFE801E17BC03576b3192",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt 1INCH",
        "variableDebtTokenSymbol": "variableDebtEth1INCH"
      }
    }
  },
  "strategies": {
    "0x8F183Ee74C790CB558232a141099b316D6C8Ba6E": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "120000000000000000000000000",
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