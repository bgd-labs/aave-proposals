## Reserve changes

### Reserves altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 0 % |
| liquidationThreshold | 77.5 % | 75 % |
| liquidationBonus | 5 % | 10 % |
| reserveFactor | 25 % | 95 % |
| borrowingEnabled | true | false |
| stableBorrowRateEnabled | true | false |
| interestRateStrategy | [0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC](https://etherscan.io/address/0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC) | [0x67a81df2b7FAf4a324D94De9Cc778704F4500478](https://etherscan.io/address/0x67a81df2b7FAf4a324D94De9Cc778704F4500478) |
| optimalUsageRatio | 80 % | 20 % |
| maxExcessUsageRatio | 20 % | 80 % |
| baseVariableBorrowRate | 0 % | 3 % |
| variableRateSlope1 | 4 % | 7 % |
| variableRateSlope2 | 100 % | 200 % |
| stableRateSlope1 | 2 % | 7 % |
| stableRateSlope2 | 100 % | 2000 % |
| interestRate | ![before](/.assets/2e987a4911a41c316461bd57acf38be5b6ae837b.svg) | ![after](/.assets/66940b7cfc53826ed2d6a31e1a82473e8d7325a1.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "interestRateStrategy": {
        "from": "0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC",
        "to": "0x67a81df2b7FAf4a324D94De9Cc778704F4500478"
      },
      "liquidationBonus": {
        "from": 10500,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7750,
        "to": 7500
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2500,
        "to": 9500
      },
      "stableBorrowRateEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "strategies": {
    "0x67a81df2b7FAf4a324D94De9Cc778704F4500478": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "30000000000000000000000000",
        "maxExcessUsageRatio": "800000000000000000000000000",
        "optimalUsageRatio": "200000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "20000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "2000000000000000000000000000"
      }
    }
  }
}
```