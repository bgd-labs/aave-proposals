## Reserve changes

### Reserves added

#### RPL ([0xD33526068D116cE69F19A9ee46F0bd304F21A51f](https://etherscan.io/address/0xD33526068D116cE69F19A9ee46F0bd304F21A51f))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 105,000 RPL |
| borrowCap | 105,000 RPL |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d](https://etherscan.io/address/0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d) |
| oracleDecimals | 8 |
| oracleDescription | RPL / USD |
| oracleLatestAnswer | 36.37527782 |
| usageAsCollateralEnabled | false |
| ltv | 0 % |
| liquidationThreshold | 0 % |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % |
| reserveFactor | 20 % |
| aToken | [0x00907f9921424583e7ffBfEdf84F92B7B2Be4977](https://etherscan.io/address/0x00907f9921424583e7ffBfEdf84F92B7B2Be4977) |
| aTokenImpl | [0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d](https://etherscan.io/address/0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d) |
| variableDebtToken | [0x786dBff3f1292ae8F92ea68Cf93c30b34B1ed04B](https://etherscan.io/address/0x786dBff3f1292ae8F92ea68Cf93c30b34B1ed04B) |
| variableDebtTokenImpl | [0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6](https://etherscan.io/address/0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6) |
| stableDebtToken | [0x3f3DF7266dA30102344A813F1a3D07f5F041B5AC](https://etherscan.io/address/0x3f3DF7266dA30102344A813F1a3D07f5F041B5AC) |
| stableDebtTokenImpl | [0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57](https://etherscan.io/address/0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xD87974E8ED49AB16d5053ba793F4e17078Be0426](https://etherscan.io/address/0xD87974E8ED49AB16d5053ba793F4e17078Be0426) |
| aTokenName | Aave Ethereum RPL |
| aTokenSymbol | aEthRPL |
| isPaused | false |
| stableDebtTokenName | Aave Ethereum Stable Debt RPL |
| stableDebtTokenSymbol | stableDebtEthRPL |
| variableDebtTokenName | Aave Ethereum Variable Debt RPL |
| variableDebtTokenSymbol | variableDebtEthRPL |
| optimalUsageRatio | 80 % |
| maxExcessUsageRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 8.5 % |
| variableRateSlope2 | 87 % |
| baseStableBorrowRate | 9.5 % |
| stableRateSlope1 | 8.5 % |
| stableRateSlope2 | 87 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/a74b1b2d3fed4f05761618942237126d814b6f7e.svg) |


## Raw diff

```json
{
  "reserves": {
    "0xD33526068D116cE69F19A9ee46F0bd304F21A51f": {
      "from": null,
      "to": {
        "aToken": "0x00907f9921424583e7ffBfEdf84F92B7B2Be4977",
        "aTokenImpl": "0x7EfFD7b47Bfd17e52fB7559d3f924201b9DbfF3d",
        "aTokenName": "Aave Ethereum RPL",
        "aTokenSymbol": "aEthRPL",
        "borrowCap": 105000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xD87974E8ED49AB16d5053ba793F4e17078Be0426",
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
        "oracle": "0x4E155eD98aFE9034b7A5962f6C84c86d869daA9d",
        "oracleDecimals": 8,
        "oracleDescription": "RPL / USD",
        "oracleLatestAnswer": 3637527782,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x3f3DF7266dA30102344A813F1a3D07f5F041B5AC",
        "stableDebtTokenImpl": "0x15C5620dfFaC7c7366EED66C20Ad222DDbB1eD57",
        "stableDebtTokenName": "Aave Ethereum Stable Debt RPL",
        "stableDebtTokenSymbol": "stableDebtEthRPL",
        "supplyCap": 105000,
        "symbol": "RPL",
        "underlying": "0xD33526068D116cE69F19A9ee46F0bd304F21A51f",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0x786dBff3f1292ae8F92ea68Cf93c30b34B1ed04B",
        "variableDebtTokenImpl": "0xaC725CB59D16C81061BDeA61041a8A5e73DA9EC6",
        "variableDebtTokenName": "Aave Ethereum Variable Debt RPL",
        "variableDebtTokenSymbol": "variableDebtEthRPL"
      }
    }
  },
  "strategies": {
    "0xD87974E8ED49AB16d5053ba793F4e17078Be0426": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "95000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "85000000000000000000000000",
        "stableRateSlope2": "870000000000000000000000000",
        "variableRateSlope1": "85000000000000000000000000",
        "variableRateSlope2": "870000000000000000000000000"
      }
    }
  }
}
```