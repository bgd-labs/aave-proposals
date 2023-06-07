## Reserve changes

### Reserves altered

#### BUSD ([0x4Fabb145d64652a948d72533023f6E7A623C7C53](https://etherscan.io/address/0x4Fabb145d64652a948d72533023f6E7A623C7C53))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x67a81df2b7FAf4a324D94De9Cc778704F4500478](https://etherscan.io/address/0x67a81df2b7FAf4a324D94De9Cc778704F4500478) | [0xB28cA2760001c9837430F20c50fD89Ed56A449f0](https://etherscan.io/address/0xB28cA2760001c9837430F20c50fD89Ed56A449f0) |
| optimalUsageRatio | 20 % | 2 % |
| maxExcessUsageRatio | 80 % | 98 % |
| variableRateSlope2 | 200 % | 300 % |
| stableRateSlope2 | 2000 % | 3000 % |
| interestRate | ![before](/.assets/66940b7cfc53826ed2d6a31e1a82473e8d7325a1.svg) | ![after](/.assets/caf95847460159571f7d6f0fbf09566915c5ca5b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4Fabb145d64652a948d72533023f6E7A623C7C53": {
      "interestRateStrategy": {
        "from": "0x67a81df2b7FAf4a324D94De9Cc778704F4500478",
        "to": "0xB28cA2760001c9837430F20c50fD89Ed56A449f0"
      }
    }
  },
  "strategies": {
    "0xB28cA2760001c9837430F20c50fD89Ed56A449f0": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "30000000000000000000000000",
        "maxExcessUsageRatio": "980000000000000000000000000",
        "optimalUsageRatio": "20000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "30000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```