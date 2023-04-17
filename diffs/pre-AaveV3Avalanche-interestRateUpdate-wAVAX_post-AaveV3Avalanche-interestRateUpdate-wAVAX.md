## Reserve changes

### Reserves altered

#### WAVAX ([0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://snowtrace.io/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | ![[0x79a906e8c998d2fb5C5D66d23c4c5416Fe0168D6](https://snowtrace.io/address/0x79a906e8c998d2fb5C5D66d23c4c5416Fe0168D6)](/.assets/43114_0x79a906e8c998d2fb5C5D66d23c4c5416Fe0168D6.svg) | ![[0xc76EF342898f1AE7E6C4632627Df683FAD8563DD](https://snowtrace.io/address/0xc76EF342898f1AE7E6C4632627Df683FAD8563DD)](/.assets/43114_0xc76EF342898f1AE7E6C4632627Df683FAD8563DD.svg) |
| optimalUsageRatio | 45 % | 65 % |
| maxExcessUsageRatio | 55 % | 35 % |
| baseVariableBorrowRate | 0 % | 1 % |
| variableRateSlope1 | 7 % | 4.72 % |
| variableRateSlope2 | 300 % | 144.28 % |
| baseStableBorrowRate | 9 % | 8.72 % |
| stableRateSlope1 | 0 % | 4.72 % |
| stableRateSlope2 | 0 % | 144.28 % |


## Raw diff

```json
{
  "reserves": {
    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7": {
      "interestRateStrategy": {
        "from": "0x79a906e8c998d2fb5C5D66d23c4c5416Fe0168D6",
        "to": "0xc76EF342898f1AE7E6C4632627Df683FAD8563DD"
      }
    }
  },
  "strategies": {
    "0xc76EF342898f1AE7E6C4632627Df683FAD8563DD": {
      "from": null,
      "to": {
        "address": "0xc76EF342898f1AE7E6C4632627Df683FAD8563DD",
        "baseStableBorrowRate": "87200000000000000000000000",
        "baseVariableBorrowRate": "10000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "47200000000000000000000000",
        "stableRateSlope2": "1442800000000000000000000000",
        "variableRateSlope1": "47200000000000000000000000",
        "variableRateSlope2": "1442800000000000000000000000"
      }
    }
  }
}
```