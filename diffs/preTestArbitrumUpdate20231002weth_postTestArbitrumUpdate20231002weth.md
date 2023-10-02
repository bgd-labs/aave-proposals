## Reserve changes

### Reserves altered

#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xdef8F50155A6cf21181E29E400E8CffAE2d50968](https://arbiscan.io/address/0xdef8F50155A6cf21181E29E400E8CffAE2d50968) | [0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3](https://arbiscan.io/address/0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3) |
| baseVariableBorrowRate | 1 % | 0 % |
| interestRate | ![before](/.assets/0503ddc95c9ff90b6308f1ba4175b90d670e81ed.svg) | ![after](/.assets/715cbb89cad22db0c20f074df5ed4b41cd5a2327.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "interestRateStrategy": {
        "from": "0xdef8F50155A6cf21181E29E400E8CffAE2d50968",
        "to": "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3"
      }
    }
  },
  "strategies": {
    "0x9a158802cD924747EF336cA3F9DE3bdb60Cf43D3": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "63000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "33000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```