## Reserve changes

### Reserves altered

#### BAL ([0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x80cb7e9E015C5331bF34e06de62443d070FD6654](https://polygonscan.com/address/0x80cb7e9E015C5331bF34e06de62443d070FD6654) | [0x54DA5057cdA764909f4c79bA9fbb2d4A214EeAe5](https://polygonscan.com/address/0x54DA5057cdA764909f4c79bA9fbb2d4A214EeAe5) |
| baseVariableBorrowRate | 3 % | 5 % |
| variableRateSlope1 | 14 % | 22 % |
| stableRateSlope1 | 10 % | 22 % |
| stableRateSlope2 | 300 % | 150 % |
| interestRate | ![before](/.assets/330013c26457182fd9217e67c8443bffe9a1b607.svg) | ![after](/.assets/6d918472bb221b9f32fa57a06095b6cfb1caa96e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3": {
      "interestRateStrategy": {
        "from": "0x80cb7e9E015C5331bF34e06de62443d070FD6654",
        "to": "0x54DA5057cdA764909f4c79bA9fbb2d4A214EeAe5"
      }
    }
  },
  "strategies": {
    "0x54DA5057cdA764909f4c79bA9fbb2d4A214EeAe5": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": "50000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
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