## Reserve changes

### Reserves altered

#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A](https://etherscan.io/address/0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A) | [0xd9d85499449f26d2A2c240defd75314f23920089](https://etherscan.io/address/0xd9d85499449f26d2A2c240defd75314f23920089) |
| baseVariableBorrowRate | 3 % | 5 % |
| variableRateSlope1 | 14 % | 22 % |
| baseStableBorrowRate | 17 % | 27 % |
| stableRateSlope1 | 20 % | 22 % |
| interestRate | ![before](/.assets/9b76f4d701a0fb8c25bd52913ac796d725cc2e09.svg) | ![after](/.assets/f3726ff23cc2fccdef4119f3fe7a7c6fe9fcd827.svg) |

## Raw diff

```json
{
  "reserves": {
    "0xba100000625a3754423978a60c9317c58a424e3D": {
      "interestRateStrategy": {
        "from": "0xCbDC7D7984D7AD59434f0B1999D2006898C40f9A",
        "to": "0xd9d85499449f26d2A2c240defd75314f23920089"
      }
    }
  },
  "strategies": {
    "0xd9d85499449f26d2A2c240defd75314f23920089": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "270000000000000000000000000",
        "baseVariableBorrowRate": "50000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "220000000000000000000000000",
        "stableRateSlope2": "1500000000000000000000000000",
        "variableRateSlope1": "220000000000000000000000000",
        "variableRateSlope2": "1500000000000000000000000000"
      }
    }
  }
}
```