## Reserve changes

### Reserves altered

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
    "0x4Fabb145d64652a948d72533023f6E7A623C7C53": {
      "interestRateStrategy": {
        "from": "0xB28cA2760001c9837430F20c50fD89Ed56A449f0",
        "to": "0xF1AafF9a4Da6Bf4Fb8fc18d39C8ffdafbAACce69"
      }
    }
  },
  "strategies": {
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