## Reserve changes

### Reserves added

#### ENS ([0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72](https://etherscan.io/address/0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,000,000 ENS |
| borrowCap | 40,000 ENS |
| debtCeiling | 3,900,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x5C00128d4d1c2F4f652C267d7bcdD7aC99C16E16](https://etherscan.io/address/0x5C00128d4d1c2F4f652C267d7bcdD7aC99C16E16) |
| oracleDecimals | 8 |
| oracleDescription | ENS / USD |
| oracleLatestAnswer | 10.40713507 |
| usageAsCollateralEnabled | true |
| ltv | 39 % |
| liquidationThreshold | 49 % |
| liquidationBonus | 8 % |
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
| aTokenName | Aave Ethereum ENS |
| aTokenSymbol | aEthENS |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt ENS |
| stableDebtTokenSymbol | stableDebtEthENS |
| variableDebtTokenName | Aave Ethereum Variable Debt ENS |
| variableDebtTokenSymbol | variableDebtEthENS |
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
    "0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72": {
      "from": null,
      "to": {
        "aToken": "0x545bD6c032eFdde65A377A6719DEF2796C8E0f2e",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum ENS",
        "aTokenSymbol": "aEthENS",
        "borrowCap": 40000,
        "borrowingEnabled": true,
        "debtCeiling": 390000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x8F183Ee74C790CB558232a141099b316D6C8Ba6E",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10800,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 4900,
        "ltv": 3900,
        "oracle": "0x5C00128d4d1c2F4f652C267d7bcdD7aC99C16E16",
        "oracleDecimals": 8,
        "oracleDescription": "ENS / USD",
        "oracleLatestAnswer": 1040713507,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x7617d02E311CdE347A0cb45BB7DF2926BBaf5347",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt ENS",
        "stableDebtTokenSymbol": "stableDebtEthENS",
        "supplyCap": 1000000,
        "symbol": "ENS",
        "underlying": "0xC18360217D8F7Ab5e7c516566761Ea12Ce7F9D72",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xd180D7fdD4092f07428eFE801E17BC03576b3192",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt ENS",
        "variableDebtTokenSymbol": "variableDebtEthENS"
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