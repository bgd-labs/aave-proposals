## Reserve changes

### Reserves added

#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 15,000,000 FRAX |
| borrowCap | 12,000,000 FRAX |
| debtCeiling | 10,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD](https://etherscan.io/address/0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD) |
| oracleDecimals | 8 |
| oracleDescription | FRAX / USD |
| oracleLatestAnswer | 0.99932715 |
| usageAsCollateralEnabled | true |
| ltv | 70 % |
| liquidationThreshold | 75 % |
| liquidationBonus | 6 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 10 % |
| aToken | [0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e](https://etherscan.io/address/0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0xd180D7fdD4092f07428eFE801E17BC03576b3192](https://etherscan.io/address/0xd180D7fdD4092f07428eFE801E17BC03576b3192) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347](https://etherscan.io/address/0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x694d4cFdaeE639239df949b6E24Ff8576A00d1f2](https://etherscan.io/address/0x694d4cFdaeE639239df949b6E24Ff8576A00d1f2) |
| aTokenName | Aave Ethereum FRAX |
| aTokenSymbol | aEthFRAX |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt FRAX |
| stableDebtTokenSymbol | stableDebtEthFRAX |
| variableDebtTokenName | Aave Ethereum Variable Debt FRAX |
| variableDebtTokenSymbol | variableDebtEthFRAX |
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
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "from": null,
      "to": {
        "aToken": "0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum FRAX",
        "aTokenSymbol": "aEthFRAX",
        "borrowCap": 12000000,
        "borrowingEnabled": true,
        "debtCeiling": 1000000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x694d4cFdaeE639239df949b6E24Ff8576A00d1f2",
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
        "oracle": "0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD",
        "oracleDecimals": 8,
        "oracleDescription": "FRAX / USD",
        "oracleLatestAnswer": 99932715,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt FRAX",
        "stableDebtTokenSymbol": "stableDebtEthFRAX",
        "supplyCap": 15000000,
        "symbol": "FRAX",
        "underlying": "0x853d955aCEf822Db058eb8505911ED77F175b99e",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xd180D7fdD4092f07428eFE801E17BC03576b3192",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt FRAX",
        "variableDebtTokenSymbol": "variableDebtEthFRAX"
      }
    }
  }
}
```