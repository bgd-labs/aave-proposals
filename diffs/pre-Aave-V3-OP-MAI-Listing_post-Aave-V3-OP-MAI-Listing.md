## Reserve changes

### Reserves added

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://optimistic.etherscan.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 7,600,000 MAI |
| borrowCap | 2,500,000 MAI |
| debtCeiling | 1,900,000 $ |
| isSiloed | false |
| isFlashloanable | false |
| eModeCategory | 0 |
| oracle | [0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0](https://optimistic.etherscan.io/address/0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0) |
| oracleDecimals | 8 |
| oracleDescription | MIMATIC / USD |
| oracleLatestAnswer | 0.99666829 |
| usageAsCollateralEnabled | true |
| ltv | 75 % |
| liquidationThreshold | 80 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0x8ffDf2DE812095b1D19CB146E4c004587C0A0692](https://optimistic.etherscan.io/address/0x8ffDf2DE812095b1D19CB146E4c004587C0A0692) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://optimistic.etherscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0xA8669021776Bc142DfcA87c21b4A52595bCbB40a](https://optimistic.etherscan.io/address/0xA8669021776Bc142DfcA87c21b4A52595bCbB40a) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://optimistic.etherscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0xa5e408678469d23efDB7694b1B0A85BB0669e8bd](https://optimistic.etherscan.io/address/0xa5e408678469d23efDB7694b1B0A85BB0669e8bd) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://optimistic.etherscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398](https://optimistic.etherscan.io/address/0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398) |
| optimalUsageRatio | 80 % |
| maxExcessUsageRatio | 20 % |
| baseVariableBorrowRate | 0 % |
| variableRateSlope1 | 4 % |
| variableRateSlope2 | 75 % |
| baseStableBorrowRate | 5 % |
| stableRateSlope1 | 4 % |
| stableRateSlope2 | 75 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/6328b8017499aaa1d67053e893c4dc04fca7def7.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xdFA46478F9e5EA86d57387849598dbFB2e964b02": {
      "from": null,
      "to": {
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "reserveFactor": 2000,
        "liquidationBonus": 10500,
        "eModeCategory": 0,
        "oracle": "0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "borrowingEnabled": true,
        "ltv": 7500,
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "debtCeiling": 190000000,
        "interestRateStrategy": "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398",
        "isSiloed": false,
        "oracleDecimals": 8,
        "supplyCap": 7600000,
        "isFrozen": false,
        "liquidationThreshold": 8000,
        "variableDebtToken": "0xA8669021776Bc142DfcA87c21b4A52595bCbB40a",
        "isFlashloanable": false,
        "decimals": 18,
        "stableDebtToken": "0xa5e408678469d23efDB7694b1B0A85BB0669e8bd",
        "usageAsCollateralEnabled": true,
        "oracleDescription": "MIMATIC / USD",
        "stableBorrowRateEnabled": false,
        "isActive": true,
        "isBorrowableInIsolation": false,
        "aToken": "0x8ffDf2DE812095b1D19CB146E4c004587C0A0692",
        "borrowCap": 2500000,
        "symbol": "MAI",
        "underlying": "0xdFA46478F9e5EA86d57387849598dbFB2e964b02",
        "oracleLatestAnswer": 99666829,
        "liquidationProtocolFee": 1000
      }
    }
  },
  "strategies": {
    "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398": {
      "from": null,
      "to": {
        "variableRateSlope1": "40000000000000000000000000",
        "baseStableBorrowRate": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "baseVariableBorrowRate": 0
      }
    }
  }
}
```