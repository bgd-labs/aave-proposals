## Reserve changes

### Reserves added

#### wstETH ([0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD](https://polygonscan.com/address/0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD))

| description | value |
| --- | --- |
| decimals | 18 |
| isActive | true |
| isFrozen | false |
| supplyCap | 1,800 wstETH |
| borrowCap | 285 wstETH |
| debtCeiling | 0 $ |
| isSiloed | false |
| isFlashloanable | false |
| eModeCategory | 3 |
| oracle | [0xA2508729b1282Cc70dd33Ed311d4A9A37383035b](https://polygonscan.com/address/0xA2508729b1282Cc70dd33Ed311d4A9A37383035b) |
| oracleDecimals | 8 |
| oracleName | wstETH/ETH/USD |
| oracleLatestAnswer | 2243.416799 |
| usageAsCollateralEnabled | true |
| ltv | 70 % |
| liquidationThreshold | 79 % |
| liquidationBonus | 7.2 % |
| liquidationProtocolFee | 10 % |
| reserveFactor | 15 % |
| aToken | [0xf59036CAEBeA7dC4b86638DFA2E3C97dA9FcCd40](https://polygonscan.com/address/0xf59036CAEBeA7dC4b86638DFA2E3C97dA9FcCd40) |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://polygonscan.com/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) |
| variableDebtToken | [0x77fA66882a8854d883101Fb8501BD3CaD347Fc32](https://polygonscan.com/address/0x77fA66882a8854d883101Fb8501BD3CaD347Fc32) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://polygonscan.com/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) |
| stableDebtToken | [0x173e54325AE58B072985DbF232436961981EA000](https://polygonscan.com/address/0x173e54325AE58B072985DbF232436961981EA000) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://polygonscan.com/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) |
| borrowingEnabled | true |
| stableBorrowRateEnabled | false |
| isBorrowableInIsolation | false |
| interestRateStrategy | [0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://polygonscan.com/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E) |
| aTokenName | Aave Polygon wstETH |
| aTokenSymbol | aPolwstETH |
| isPaused | false |
| stableDebtTokenName | Aave Polygon Stable Debt wstETH |
| stableDebtTokenSymbol | stableDebtPolwstETH |
| variableDebtTokenName | Aave Polygon Variable Debt wstETH |
| variableDebtTokenSymbol | variableDebtPolwstETH |
| optimalUsageRatio | 45 % |
| maxExcessUsageRatio | 55 % |
| baseVariableBorrowRate | 0.25 % |
| variableRateSlope1 | 4.5 % |
| variableRateSlope2 | 80 % |
| baseStableBorrowRate | 5.5 % |
| stableRateSlope1 | 4.5 % |
| stableRateSlope2 | 80 % |
| optimalStableToTotalDebtRatio | 20 % |
| maxExcessStableToTotalDebtRatio | 80 % |
| interestRate | ![ir](/.assets/6c6aa53c31467fe6d6e1e00491cf89ca125ee373.svg) |

### Reserves altered

#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| eModeCategory | 0 | 3 |


## Raw diff

```json
{
  "eModes": {
    "3": {
      "from": null,
      "to": {
        "eModeCategory": 3,
        "label": "ETH correlated",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9300,
        "ltv": 9000,
        "priceSource": "0x0000000000000000000000000000000000000000"
      }
    }
  },
  "reserves": {
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "eModeCategory": {
        "from": 0,
        "to": 3
      }
    },
    "0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD": {
      "from": null,
      "to": {
        "aToken": "0xf59036CAEBeA7dC4b86638DFA2E3C97dA9FcCd40",
        "aTokenImpl": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "aTokenName": "Aave Polygon wstETH",
        "aTokenSymbol": "aPolwstETH",
        "borrowCap": 285,
        "borrowingEnabled": true,
        "debtCeiling": 0,
        "decimals": 18,
        "eModeCategory": 3,
        "interestRateStrategy": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
        "isActive": true,
        "isBorrowableInIsolation": false,
        "isFlashloanable": false,
        "isFrozen": false,
        "isPaused": false,
        "isSiloed": false,
        "liquidationBonus": 10720,
        "liquidationProtocolFee": 1000,
        "liquidationThreshold": 7900,
        "ltv": 7000,
        "oracle": "0xA2508729b1282Cc70dd33Ed311d4A9A37383035b",
        "oracleDecimals": 8,
        "oracleLatestAnswer": 224341679900,
        "oracleName": "wstETH/ETH/USD",
        "reserveFactor": 1500,
        "stableBorrowRateEnabled": false,
        "stableDebtToken": "0x173e54325AE58B072985DbF232436961981EA000",
        "stableDebtTokenImpl": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "stableDebtTokenName": "Aave Polygon Stable Debt wstETH",
        "stableDebtTokenSymbol": "stableDebtPolwstETH",
        "supplyCap": 1800,
        "symbol": "wstETH",
        "underlying": "0x03b54A6e9a984069379fae1a4fC4dBAE93B3bCCD",
        "usageAsCollateralEnabled": true,
        "variableDebtToken": "0x77fA66882a8854d883101Fb8501BD3CaD347Fc32",
        "variableDebtTokenImpl": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "variableDebtTokenName": "Aave Polygon Variable Debt wstETH",
        "variableDebtTokenSymbol": "variableDebtPolwstETH"
      }
    }
  },
  "strategies": {
    "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "55000000000000000000000000",
        "baseVariableBorrowRate": "2500000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "45000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "45000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```