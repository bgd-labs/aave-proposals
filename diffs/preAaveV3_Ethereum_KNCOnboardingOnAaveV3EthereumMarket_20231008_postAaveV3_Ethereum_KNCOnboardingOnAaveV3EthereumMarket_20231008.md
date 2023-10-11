## Reserve changes

### Reserves added

#### KNC ([0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202](https://etherscan.io/address/0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,200,000 KNC |
| borrowCap | 650,000 KNC |
| debtCeiling | 1,000,000 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0xf8fF43E991A81e6eC886a3D281A2C6cC19aE70Fc](https://etherscan.io/address/0xf8fF43E991A81e6eC886a3D281A2C6cC19aE70Fc) |
| oracleDecimals | 8 |
| oracleDescription | KNC / USD |
| oracleLatestAnswer | 0.69127543 |
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
| interestRateStrategy | [0xf6733B9842883BFE0e0a940eA2F572676af31bde](https://etherscan.io/address/0xf6733B9842883BFE0e0a940eA2F572676af31bde) |
| aTokenName | Aave Ethereum KNC |
| aTokenSymbol | aEthKNC |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt KNC |
| stableDebtTokenSymbol | stableDebtEthKNC |
| variableDebtTokenName | Aave Ethereum Variable Debt KNC |
| variableDebtTokenSymbol | variableDebtEthKNC |
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
    "0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202": {
      "from": null,
      "to": {
        "aToken": "0x1bA9843bD4327c6c77011406dE5fA8749F7E3479",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum KNC",
        "aTokenSymbol": "aEthKNC",
        "borrowCap": 650000,
        "borrowingEnabled": true,
        "debtCeiling": 100000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xf6733B9842883BFE0e0a940eA2F572676af31bde",
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
        "oracle": "0xf8fF43E991A81e6eC886a3D281A2C6cC19aE70Fc",
        "oracleDecimals": 8,
        "oracleDescription": "KNC / USD",
        "oracleLatestAnswer": 69127543,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xc3115D0660b93AeF10F298886ae22E3Dd477E482",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt KNC",
        "stableDebtTokenSymbol": "stableDebtEthKNC",
        "supplyCap": 1200000,
        "symbol": "KNC",
        "underlying": "0xdeFA4e8a7bcBA345F687a2f1456F5Edd9CE97202",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x655568bDd6168325EC7e58Bf39b21A856F906Dc2",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt KNC",
        "variableDebtTokenSymbol": "variableDebtEthKNC"
      }
    }
  }
}
```