## Reserve changes

### Reserves added

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 4,800,000 MAI |
| borrowCap | 2,400,000 MAI |
| debtCeiling | 1,200,000 $ |
| isSiloed | false |
| isFlashloanable | false |
| eModeCategory | 0 |
| oracle | [0x59644ec622243878d1464A9504F9e9a31294128a](https://arbiscan.io/address/0x59644ec622243878d1464A9504F9e9a31294128a) |
| oracleDecimals | 8 |
| oracleDescription | MIMATIC / USD |
| oracleLatestAnswer | 0.99744654 |
| usageAsCollateralEnabled | true |
| ltv | 75 % |
| liquidationThreshold | 80 % |
| liquidationBonus | 5 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 20 % |
| aToken | [0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA](https://arbiscan.io/address/0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907](https://arbiscan.io/address/0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://arbiscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841](https://arbiscan.io/address/0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://arbiscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://arbiscan.io/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E) |
| aTokenName | Aave Arbitrum MAI |
| aTokenSymbol | aArbMAI |
| isPaused | false |
| stableDebtTokenName | Aave Arbitrum Stable Debt MAI |
| stableDebtTokenSymbol | stableDebtArbMAI |
| variableDebtTokenName | Aave Arbitrum Variable Debt MAI |
| variableDebtTokenSymbol | variableDebtArbMAI |
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
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "from": null,
      "to": {
        "aToken": "0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "aTokenName": "Aave Arbitrum MAI",
        "aTokenSymbol": "aArbMAI",
        "borrowCap": 2400000,
        "borrowingEnabled": true,
        "debtCeiling": 120000000,
        "decimals": 18,
        "eModeCategory": 0,
        "interestRateStrategy": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10500,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 8000,
        "ltv": 7500,
        "oracle": "0x59644ec622243878d1464A9504F9e9a31294128a",
        "oracleDecimals": 8,
        "oracleDescription": "MIMATIC / USD",
        "oracleLatestAnswer": 99744654,
        "reserveFactor": 2000,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "stableDebtTokenName": "Aave Arbitrum Stable Debt MAI",
        "stableDebtTokenSymbol": "stableDebtArbMAI",
        "supplyCap": 4800000,
        "symbol": "MAI",
        "underlying": "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "variableDebtTokenName": "Aave Arbitrum Variable Debt MAI",
        "variableDebtTokenSymbol": "variableDebtArbMAI"
      }
    }
  },
  "strategies": {
    "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "50000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```