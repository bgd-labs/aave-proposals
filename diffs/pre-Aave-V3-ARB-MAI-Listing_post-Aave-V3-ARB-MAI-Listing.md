## Reserve changes

### Reserves added

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value |
| --- | --- |
| aToken | [0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA](https://https://arbiscan.io/address/0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| debtCeiling | 200,000,000 |
| eModeCategory | 0 |
| supplyCap | 1,200,000 MAI |
| borrowCap | 1,000,000 MAI |
| borrowingEnabled | true |
| decimals | 18 |
| interestRateStrategy | ![[0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://https://arbiscan.io/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E)](/.assets/42161_0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E.svg) |
| isActive | true |
| isBorrowableInIsolation | false |
| isFlashloanable | false |
| isFrozen | false |
| isSiloed | false |
| liquidationBonus | 7.5 % |
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
  "strategies": {
    "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E": {
      "from": null,
      "to": {
        "stableRateSlope2": "750000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "baseStableBorrowRate": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "baseVariableBorrowRate": 0
      }
    }
  },
  "reserves": {
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "from": null,
      "to": {
        "usageAsCollateralEnabled": true,
        "liquidationProtocolFee": 1000,
        "borrowingEnabled": true,
        "stableBorrowRateEnabled": false,
        "isFrozen": false,
        "oracleLatestAnswer": 99744654,
        "liquidationThreshold": 8000,
        "borrowCap": 1000000,
        "isSiloed": false,
        "isActive": true,
        "oracleDescription": "MIMATIC / USD",
        "supplyCap": 1200000,
        "aToken": "0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA",
        "stableDebtToken": "0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "isFlashloanable": false,
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "ltv": 7500,
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "underlying": "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d",
        "decimals": 18,
        "interestRateStrategy": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
        "oracleDecimals": 8,
        "reserveFactor": 2000,
        "symbol": "MAI",
        "variableDebtToken": "0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907",
        "liquidationBonus": 10750,
        "isBorrowableInIsolation": false,
        "eModeCategory": 0,
        "debtCeiling": 200000000,
        "oracle": "0x59644ec622243878d1464A9504F9e9a31294128a"
      }
    }
  }
}
```