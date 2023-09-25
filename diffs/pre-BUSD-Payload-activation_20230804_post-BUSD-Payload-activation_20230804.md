## Reserve changes

### Reserves altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 95 % | 99.9 % |
| interestRateStrategy | [0x531F1D684c35e570eE580D6881D0844caee682cd](https://etherscan.io/address/0x531F1D684c35e570eE580D6881D0844caee682cd) | [0xb70e28437Aec70a8cfE5240F54c463cF849bE17C](https://etherscan.io/address/0xb70e28437Aec70a8cfE5240F54c463cF849bE17C) |
| optimalUsageRatio | 20 % | 1 % |
| maxExcessUsageRatio | 80 % | 99 % |
| baseVariableBorrowRate | 3 % | 100 % |
| variableRateSlope1 | 7 % | 70 % |
| variableRateSlope2 | 200 % | 300 % |
| stableRateSlope1 | 7 % | 70 % |
| stableRateSlope2 | 200 % | 300 % |
| interestRate | ![before](/.assets/eb3102eea1cd584bc9575f6fee13716b7ec769d8.svg) | ![after](/.assets/580220443634a43f0f202f2f55e802420e34aaef.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "interestRateStrategy": {
        "from": "0x531F1D684c35e570eE580D6881D0844caee682cd",
        "to": "0xb70e28437Aec70a8cfE5240F54c463cF849bE17C"
      },
      "reserveFactor": {
        "from": 9500,
        "to": 9990
      }
    }
  },
  "strategies": {
    "0xb70e28437Aec70a8cfE5240F54c463cF849bE17C": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "1000000000000000000000000000",
        "maxExcessUsageRatio": "990000000000000000000000000",
        "optimalUsageRatio": "10000000000000000000000000",
        "stableRateSlope1": "700000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "700000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```