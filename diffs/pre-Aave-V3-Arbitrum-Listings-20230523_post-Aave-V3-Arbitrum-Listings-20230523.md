## Reserve changes

### Reserves added

#### rETH ([0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8](https://https://arbiscan.io/address/0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 325 rETH |
| borrowCap | 85 rETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | true |
| eModeCategory | 0 |
| oracle | [0x853844459106feefd8C7C4cC34066bFBC0531722](https://https://arbiscan.io/address/0x853844459106feefd8C7C4cC34066bFBC0531722) |
| oracleName | rETH/ETH/USD |
| oracleLatestAnswer | 198,372,582,495 |
| usageAsCollateralEnabled | true |
| ltv | 67 % |
| liquidationThreshold | 74 % |
| liquidationBonus | 7.5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0x8Eb270e296023E9D92081fdF967dDd7878724424](https://https://arbiscan.io/address/0x8Eb270e296023E9D92081fdF967dDd7878724424) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0xCE186F6Cccb0c955445bb9d10C59caE488Fea559](https://https://arbiscan.io/address/0xCE186F6Cccb0c955445bb9d10C59caE488Fea559) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://https://arbiscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc](https://https://arbiscan.io/address/0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://https://arbiscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A](https://https://arbiscan.io/address/0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A) |
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
    "0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8": {
      "from": null,
      "to": {
        "aToken": "0x8Eb270e296023E9D92081fdF967dDd7878724424",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "borrowCap": 85,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": true,
        "isFrozen": false,
        "isSiloed": false,
        "liquidationBonus": 10750,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7400,
        "ltv": 6700,
        "oracle": "0x853844459106feefd8C7C4cC34066bFBC0531722",
        "oracleLatestAnswer": 198372582495,
        "oracleName": "rETH/ETH/USD",
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x3EF10DFf4928279c004308EbADc4Db8B7620d6fc",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "supplyCap": 325,
        "symbol": "rETH",
        "underlying": "0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0xCE186F6Cccb0c955445bb9d10C59caE488Fea559",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3"
      }
    }
  },
  "strategies": {
    "0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A": {
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