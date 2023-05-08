## Reserve changes

### Reserves added

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://optimistic.etherscan.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value |
| --- | --- |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://optimistic.etherscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| supplyCap | 7,600,000 MAI |
| borrowCap | 2,500,000 MAI |
| aToken | [0x8ffDf2DE812095b1D19CB146E4c004587C0A0692](https://optimistic.etherscan.io/address/0x8ffDf2DE812095b1D19CB146E4c004587C0A0692) |
| borrowingEnabled | true |
| debtCeiling | 190,000,000 |
| decimals | 18 |
| eModeCategory | 0 |
| interestRateStrategy | ![[0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398](https://optimistic.etherscan.io/address/0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398)](/.assets/10_0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398.svg) |
| isActive | true |
| isBorrowableInIsolation | false |
| isFlashloanable | false |
| isFrozen | false |
| isSiloed | false |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| liquidationThreshold | 80 % |
| ltv | 75 % |
| oracle | [0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0](https://optimistic.etherscan.io/address/0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0) |
| oracleDecimals | 8 |
| oracleDescription | MIMATIC / USD |
| oracleLatestAnswer | 99,666,829 |
| reserveFactor | 20 % |
| stableBorrowRateEnabled | false |
| stableDebtToken | [0xa5e408678469d23efDB7694b1B0A85BB0669e8bd](https://optimistic.etherscan.io/address/0xa5e408678469d23efDB7694b1B0A85BB0669e8bd) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://optimistic.etherscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| usageAsCollateralEnabled | true |
| variableDebtToken | [0xA8669021776Bc142DfcA87c21b4A52595bCbB40a](https://optimistic.etherscan.io/address/0xA8669021776Bc142DfcA87c21b4A52595bCbB40a) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://optimistic.etherscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
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


## Raw diff

```json
{
  "reserves": {
    "0xdFA46478F9e5EA86d57387849598dbFB2e964b02": {
      "from": null,
      "to": {
        "reserveFactor": 2000,
        "usageAsCollateralEnabled": true,
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "stableBorrowRateEnabled": false,
        "liquidationThreshold": 8000,
        "decimals": 18,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "interestRateStrategy": "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398",
        "oracleDescription": "MIMATIC / USD",
        "aToken": "0x8ffDf2DE812095b1D19CB146E4c004587C0A0692",
        "isBorrowableInIsolation": false,
        "borrowingEnabled": true,
        "stableDebtToken": "0xa5e408678469d23efDB7694b1B0A85BB0669e8bd",
        "oracle": "0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0",
        "eModeCategory": 0,
        "supplyCap": 7600000,
        "isFrozen": false,
        "isFlashloanable": false,
        "ltv": 7500,
        "borrowCap": 2500000,
        "isActive": true,
        "underlying": "0xdFA46478F9e5EA86d57387849598dbFB2e964b02",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "symbol": "MAI",
        "isSiloed": false,
        "debtCeiling": 190000000,
        "variableDebtToken": "0xA8669021776Bc142DfcA87c21b4A52595bCbB40a",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "oracleDecimals": 8,
        "oracleLatestAnswer": 99666829
      }
    }
  },
  "strategies": {
    "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398": {
      "from": null,
      "to": {
        "variableRateSlope1": "40000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "variableRateSlope2": "750000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "baseStableBorrowRate": "50000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000"
      }
    }
  }
}
```