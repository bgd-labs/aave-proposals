## Reserve changes

### Reserves added

#### STG ([0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6](https://etherscan.io/address/0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 10,000,000 STG |
| borrowCap | 5,500,000 STG |
| debtCeiling | 3,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d](https://etherscan.io/address/0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d) |
| oracleDecimals | 8 |
| oracleDescription | STG / USD |
| oracleLatestAnswer | 0.43762596 |
| usageAsCollateralEnabled | true |
| ltv | 35 % |
| liquidationThreshold | 40 % |
| liquidationBonus | 10 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x1bA9843bD4327c6c77011406dE5fA8749F7E3479](https://etherscan.io/address/0x1bA9843bD4327c6c77011406dE5fA8749F7E3479) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x655568bDd6168325EC7e58Bf39b21A856F906Dc2](https://etherscan.io/address/0x655568bDd6168325EC7e58Bf39b21A856F906Dc2) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0xc3115D0660b93AeF10F298886ae22E3Dd477E482](https://etherscan.io/address/0xc3115D0660b93AeF10F298886ae22E3Dd477E482) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F](https://etherscan.io/address/0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F) |
| aTokenName | Aave Ethereum STG |
| aTokenSymbol | aEthSTG |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt STG |
| stableDebtTokenSymbol | stableDebtEthSTG |
| variableDebtTokenName | Aave Ethereum Variable Debt STG |
| variableDebtTokenSymbol | variableDebtEthSTG |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 7 % |
| variableRateSlope2 | 300 % |
| baseStableBorrowRate | 10 % |
| stableRateSlope1 | 13 % |
| stableRateSlope2 | 300 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/eda3aded0333ece535adb2c0df7f1b16add284a2.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6": {
      "from": null,
      "to": {
        "aToken": "0x1bA9843bD4327c6c77011406dE5fA8749F7E3479",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum STG",
        "aTokenSymbol": "aEthSTG",
        "borrowCap": 5500000,
        "borrowingEnabled": true,
        "debtCeiling": 300000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0x27eFE5db315b71753b2a38ED3d5dd7E9362ba93F",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 11000,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 4000,
        "ltv": 3500,
        "oracle": "0x7A9f34a0Aa917D438e9b6E630067062B7F8f6f3d",
        "oracleDecimals": 8,
        "oracleDescription": "STG / USD",
        "oracleLatestAnswer": 43762596,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xc3115D0660b93AeF10F298886ae22E3Dd477E482",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt STG",
        "stableDebtTokenSymbol": "stableDebtEthSTG",
        "supplyCap": 10000000,
        "symbol": "STG",
        "underlying": "0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x655568bDd6168325EC7e58Bf39b21A856F906Dc2",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt STG",
        "variableDebtTokenSymbol": "variableDebtEthSTG"
      }
    }
  }
}
```