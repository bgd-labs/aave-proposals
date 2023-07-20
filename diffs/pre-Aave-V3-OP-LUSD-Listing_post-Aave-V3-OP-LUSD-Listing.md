## Reserve changes

### Reserves added

#### LUSD ([0xc40F949F8a4e094D1b49a23ea9241D289B7b2819](https://optimistic.etherscan.io/address/0xc40F949F8a4e094D1b49a23ea9241D289B7b2819))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 3,000,000 LUSD |
| borrowCap | 1,210,000 LUSD |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | false |
| eModeCategory | 0 |
| oracle | [0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052](https://optimistic.etherscan.io/address/0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052) |
| oracleDecimals | 8 |
| oracleDescription | LUSD / USD |
| oracleLatestAnswer | 1.01240131 |
| usageAsCollateralEnabled | false |
| ltv | 0 % |
| liquidationThreshold | 0 % |
| liquidationBonus | 0 % |
| liquidationProtocolFee | 0 % |
| reserveFactor | 10 % |
| aToken | [0x8Eb270e296023E9D92081fdF967dDd7878724424](https://optimistic.etherscan.io/address/0x8Eb270e296023E9D92081fdF967dDd7878724424) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://optimistic.etherscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0xCE186F6Cccb0c955445bb9d10C59caE488Fea559](https://optimistic.etherscan.io/address/0xCE186F6Cccb0c955445bb9d10C59caE488Fea559) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://optimistic.etherscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc](https://optimistic.etherscan.io/address/0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://optimistic.etherscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xc76EF342898f1AE7E6C4632627Df683FAD8563DD](https://optimistic.etherscan.io/address/0xc76EF342898f1AE7E6C4632627Df683FAD8563DD) |
| aTokenName | Aave Optimism LUSD |
| aTokenSymbol | aOptLUSD |
| isPaused | false |
| stableDebtTokenName | Aave Optimism Stable Debt LUSD |
| stableDebtTokenSymbol | stableDebtOptLUSD |
| variableDebtTokenName | Aave Optimism Variable Debt LUSD |
| variableDebtTokenSymbol | variableDebtOptLUSD |
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
    "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819": {
      "from": null,
      "to": {
        "aToken": "0x8Eb270e296023E9D92081fdF967dDd7878724424",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "aTokenName": "Aave Optimism LUSD",
        "aTokenSymbol": "aOptLUSD",
        "borrowCap": 1210000,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xc76EF342898f1AE7E6C4632627Df683FAD8563DD",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 0,
        "liquidationProtocolFee": 0,
        "liquidationThreshold": 0,
        "ltv": 0,
        "oracle": "0x9dfc79Aaeb5bb0f96C6e9402671981CdFc424052",
        "oracleDecimals": 8,
        "oracleDescription": "LUSD / USD",
        "oracleLatestAnswer": 101240131,
        "reserveFactor": 1000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "stableDebtTokenName": "Aave Optimism Stable Debt LUSD",
        "stableDebtTokenSymbol": "stableDebtOptLUSD",
        "supplyCap": 3000000,
        "symbol": "LUSD",
        "underlying": "0xc40F949F8a4e094D1b49a23ea9241D289B7b2819",
        "usageAsCollateralEnabled": false,
        "variableDebtToken": "0xCE186F6Cccb0c955445bb9d10C59caE488Fea559",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "variableDebtTokenName": "Aave Optimism Variable Debt LUSD",
        "variableDebtTokenSymbol": "variableDebtOptLUSD"
      }
    }
  },
  "strategies": {
    "0xc76EF342898f1AE7E6C4632627Df683FAD8563DD": {
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