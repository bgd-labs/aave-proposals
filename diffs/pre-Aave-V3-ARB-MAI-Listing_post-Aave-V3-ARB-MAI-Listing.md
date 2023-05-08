## Reserve changes

### Reserves added

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value |
| --- | --- |
| supplyCap | 4,800,000 MAI |
| borrowCap | 2,400,000 MAI |
| aToken | [0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA](https://https://arbiscan.io/address/0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| borrowingEnabled | true |
| debtCeiling | 120,000,000 |
| decimals | 18 |
| eModeCategory | 0 |
| interestRateStrategy | ![[0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://https://arbiscan.io/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E)](/.assets/42161_0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E.svg) |
| isActive | true |
| isBorrowableInIsolation | false |
| isFlashloanable | false |
| isFrozen | false |
| isSiloed | false |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| liquidationThreshold | 80 % |
| ltv | 75 % |
| oracle | [0x59644ec622243878d1464A9504F9e9a31294128a](https://https://arbiscan.io/address/0x59644ec622243878d1464A9504F9e9a31294128a) |
| oracleDecimals | 8 |
| oracleDescription | MIMATIC / USD |
| oracleLatestAnswer | 99,744,654 |
| reserveFactor | 20 % |
| stableBorrowRateEnabled | false |
| stableDebtToken | [0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841](https://https://arbiscan.io/address/0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://https://arbiscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| usageAsCollateralEnabled | true |
| variableDebtToken | [0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907](https://https://arbiscan.io/address/0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://https://arbiscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
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
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "from": null,
      "to": {
        "symbol": "MAI",
        "variableDebtToken": "0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "debtCeiling": 120000000,
        "oracleDescription": "MIMATIC / USD",
        "liquidationBonus": 10500,
        "isSiloed": false,
        "isFlashloanable": false,
        "oracleLatestAnswer": 99744654,
        "isBorrowableInIsolation": false,
        "ltv": 7500,
        "interestRateStrategy": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
        "oracle": "0x59644ec622243878d1464A9504F9e9a31294128a",
        "liquidationThreshold": 8000,
        "reserveFactor": 2000,
        "borrowingEnabled": true,
        "isFrozen": false,
        "usageAsCollateralEnabled": true,
        "decimals": 18,
        "liquidationProtocolFee": 1000,
        "isActive": true,
        "aToken": "0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA",
        "oracleDecimals": 8,
        "borrowCap": 2400000,
        "stableDebtToken": "0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "eModeCategory": 0,
        "supplyCap": 4800000,
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "underlying": "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d",
        "stableBorrowRateEnabled": false
      }
    }
  },
  "strategies": {
    "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E": {
      "from": null,
      "to": {
        "stableRateSlope1": "40000000000000000000000000",
        "baseStableBorrowRate": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "200000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```