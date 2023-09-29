## Reserve changes

### Reserve altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x67a81df2b7FAf4a324D94De9Cc778704F4500478](https://etherscan.io/address/0x67a81df2b7FAf4a324D94De9Cc778704F4500478) | [0x531F1D684c35e570eE580D6881D0844caee682cd](https://etherscan.io/address/0x531F1D684c35e570eE580D6881D0844caee682cd) |
| stableRateSlope2 | 2000 % | 200 % |
| interestRate | ![before](/.assets/66940b7cfc53826ed2d6a31e1a82473e8d7325a1.svg) | ![after](/.assets/eb3102eea1cd584bc9575f6fee13716b7ec769d8.svg) |

#### BUSD ([0x4Fabb145d64652a948d72533023f6E7A623C7C53](https://etherscan.io/address/0x4Fabb145d64652a948d72533023f6E7A623C7C53))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xB28cA2760001c9837430F20c50fD89Ed56A449f0](https://etherscan.io/address/0xB28cA2760001c9837430F20c50fD89Ed56A449f0) | [0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69](https://etherscan.io/address/0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69) |
| optimalUsageRatio | 2 % | 1 % |
| maxExcessUsageRatio | 98 % | 99 % |
| baseVariableBorrowRate | 3 % | 100 % |
| variableRateSlope1 | 7 % | 70 % |
| stableRateSlope1 | 7 % | 70 % |
| stableRateSlope2 | 3000 % | 300 % |
| interestRate | ![before](/.assets/caf95847460159571f7d6f0fbf09566915c5ca5b.svg) | ![after](/.assets/580220443634a43f0f202f2f55e802420e34aaef.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "interestRateStrategy": {
        "from": "0x67a81df2b7FAf4a324D94De9Cc778704F4500478",
        "to": "0x531F1D684c35e570eE580D6881D0844caee682cd"
      }
    },
    "0x4Fabb145d64652a948d72533023f6E7A623C7C53": {
      "interestRateStrategy": {
        "from": "0xB28cA2760001c9837430F20c50fD89Ed56A449f0",
        "to": "0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69"
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
    },
    "0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69": {
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