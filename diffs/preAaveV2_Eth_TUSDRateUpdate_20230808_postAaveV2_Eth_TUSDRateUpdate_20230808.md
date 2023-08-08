## Reserve changes

### Reserves altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x67a81df2b7FAf4a324D94De9Cc778704F4500478](https://etherscan.io/address/0x67a81df2b7FAf4a324D94De9Cc778704F4500478) | [0x531F1D684c35e570eE580D6881D0844caee682cd](https://etherscan.io/address/0x531F1D684c35e570eE580D6881D0844caee682cd) |
| stableRateSlope2 | 2000 % | 200 % |
| interestRate | ![before](/.assets/66940b7cfc53826ed2d6a31e1a82473e8d7325a1.svg) | ![after](/.assets/eb3102eea1cd584bc9575f6fee13716b7ec769d8.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "interestRateStrategy": {
        "from": "0x67a81df2b7FAf4a324D94De9Cc778704F4500478",
        "to": "0x531F1D684c35e570eE580D6881D0844caee682cd"
      }
    }
  },
  "strategies": {
    "0x531F1D684c35e570eE580D6881D0844caee682cd": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "30000000000000000000000000",
        "maxExcessUsageRatio": "800000000000000000000000000",
        "optimalUsageRatio": "200000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "2000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "2000000000000000000000000000"
      }
    }
  }
}
```