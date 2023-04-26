## Reserve changes

### Reserves added

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://optimistic.etherscan.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value |
| --- | --- |
| supplyCap | 2,200,000 MAI |
| borrowCap | 1,200,000 MAI |
| aToken | [0x8ffDf2DE812095b1D19CB146E4c004587C0A0692](https://optimistic.etherscan.io/address/0x8ffDf2DE812095b1D19CB146E4c004587C0A0692) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://optimistic.etherscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| borrowingEnabled | true |
| debtCeiling | 200,000,000 |
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
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "oracle": "0x73A3919a69eFCd5b19df8348c6740bB1446F5ed0",
        "isFrozen": false,
        "isBorrowableInIsolation": false,
        "ltv": 7500,
        "decimals": 18,
        "isFlashloanable": false,
        "variableDebtToken": "0xA8669021776Bc142DfcA87c21b4A52595bCbB40a",
        "liquidationThreshold": 8000,
        "underlying": "0xdFA46478F9e5EA86d57387849598dbFB2e964b02",
        "debtCeiling": 200000000,
        "liquidationBonus": 10500,
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "liquidationProtocolFee": 1000,
        "oracleDescription": "MIMATIC / USD",
        "oracleLatestAnswer": 99666829,
        "stableDebtToken": "0xa5e408678469d23efDB7694b1B0A85BB0669e8bd",
        "interestRateStrategy": "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398",
        "stableBorrowRateEnabled": false,
        "usageAsCollateralEnabled": true,
        "isSiloed": false,
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "borrowingEnabled": true,
        "symbol": "MAI",
        "reserveFactor": 2000,
        "aToken": "0x8ffDf2DE812095b1D19CB146E4c004587C0A0692",
        "oracleDecimals": 8,
        "borrowCap": 1200000,
        "supplyCap": 2200000,
        "isActive": true,
        "eModeCategory": 0
      }
    }
  },
  "strategies": {
    "0xD624AFA34614B4fe7FEe7e1751a2E5E04fb47398": {
      "from": null,
      "to": {
        "variableRateSlope1": "40000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "baseStableBorrowRate": "50000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```