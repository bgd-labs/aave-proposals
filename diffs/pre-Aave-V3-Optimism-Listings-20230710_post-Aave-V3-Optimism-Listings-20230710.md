## Reserve changes

### Reserves added

#### rETH ([0x9Bcef72be871e61ED4fBbc7630889beE758eb81D](https://optimistic.etherscan.io/address/0x9Bcef72be871e61ED4fBbc7630889beE758eb81D))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 6,000 rETH |
| borrowCap | 720 rETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 2 |
| oracle | [0x52d5F9f884CA21C27E2100735d793C6771eAB793](https://optimistic.etherscan.io/address/0x52d5F9f884CA21C27E2100735d793C6771eAB793) |
| oracleDecimals | 8 |
| oracleDescription | rETH/ETH/USD |
| oracleLatestAnswer | 2026.60356782 |
| usageAsCollateralEnabled | true |
| ltv | 67 % |
| liquidationThreshold | 74 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x724dc807b04555b71ed48a6896b6F41593b8C637](https://optimistic.etherscan.io/address/0x724dc807b04555b71ed48a6896b6F41593b8C637) |
| aTokenImpl | [0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B](https://optimistic.etherscan.io/address/0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B) |
| variableDebtToken | [0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6](https://optimistic.etherscan.io/address/0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6) |
| variableDebtTokenImpl | [0x04a8D477eE202aDCE1682F5902e1160455205b12](https://optimistic.etherscan.io/address/0x04a8D477eE202aDCE1682F5902e1160455205b12) |
| stableDebtToken | [0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a](https://optimistic.etherscan.io/address/0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a) |
| stableDebtTokenImpl | [0x6b4E260b765B3cA1514e618C0215A6B7839fF93e](https://optimistic.etherscan.io/address/0x6b4E260b765B3cA1514e618C0215A6B7839fF93e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0x3B57B081dA6Af5e2759A57bD3211932Cb6176997](https://optimistic.etherscan.io/address/0x3B57B081dA6Af5e2759A57bD3211932Cb6176997) |
| aTokenName | Aave Optimism rETH |
| aTokenSymbol | aOptrETH |
| isPaused | false |
| stableDebtTokenName | Aave Optimism Stable Debt rETH |
| stableDebtTokenSymbol | stableDebtOptrETH |
| variableDebtTokenName | Aave Optimism Variable Debt rETH |
| variableDebtTokenSymbol | variableDebtOptrETH |
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
| eMode.label | ETH correlated |
| eMode.ltv | 90 % |
| eMode.liquidationThreshold | 93 % |
| eMode.liquidationBonus | 1 % |
| eMode.priceSource | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "reserves": {
    "0x9Bcef72be871e61ED4fBbc7630889beE758eb81D": {
      "from": null,
      "to": {
        "aToken": "0x724dc807b04555b71ed48a6896b6F41593b8C637",
        "aTokenImpl": "0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B",
        "aTokenName": "Aave Optimism rETH",
        "aTokenSymbol": "aOptrETH",
        "borrowCap": 720,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 2,
        "interestRateStrategy": "0x3B57B081dA6Af5e2759A57bD3211932Cb6176997",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7400,
        "ltv": 6700,
        "oracle": "0x52d5F9f884CA21C27E2100735d793C6771eAB793",
        "oracleDecimals": 8,
        "oracleDescription": "rETH/ETH/USD",
        "oracleLatestAnswer": 202660356782,
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0xDC1fad70953Bb3918592b6fCc374fe05F5811B6a",
        "stableDebtTokenImpl": "0x6b4E260b765B3cA1514e618C0215A6B7839fF93e",
        "stableDebtTokenName": "Aave Optimism Stable Debt rETH",
        "stableDebtTokenSymbol": "stableDebtOptrETH",
        "supplyCap": 6000,
        "symbol": "rETH",
        "underlying": "0x9Bcef72be871e61ED4fBbc7630889beE758eb81D",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xf611aEb5013fD2c0511c9CD55c7dc5C1140741A6",
        "variableDebtTokenImpl": "0x04a8D477eE202aDCE1682F5902e1160455205b12",
        "variableDebtTokenName": "Aave Optimism Variable Debt rETH",
        "variableDebtTokenSymbol": "variableDebtOptrETH"
      }
    }
  },
  "strategies": {
    "0x3B57B081dA6Af5e2759A57bD3211932Cb6176997": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "100000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "130000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```