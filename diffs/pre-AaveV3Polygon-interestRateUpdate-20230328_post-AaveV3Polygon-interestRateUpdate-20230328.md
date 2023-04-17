## Reserve changes

### Reserves altered

#### BAL ([0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | ![[0x4b8D3277d49E114C8F2D6E0B2eD310e29226fe16](https://polygonscan.com/address/0x4b8D3277d49E114C8F2D6E0B2eD310e29226fe16)](/.assets/137_0x4b8D3277d49E114C8F2D6E0B2eD310e29226fe16.svg) | ![[0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E](https://polygonscan.com/address/0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E)](/.assets/137_0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E.svg) |
| baseVariableBorrowRate | 3 % | 5 % |
| variableRateSlope1 | 14 % | 22 % |
| baseStableBorrowRate | 16 % | 27 % |
| stableRateSlope1 | 0 % | 22 % |
| stableRateSlope2 | 0 % | 150 % |


## Raw diff

```json
{
  "reserves": {
    "0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3": {
      "interestRateStrategy": {
        "from": "0x4b8D3277d49E114C8F2D6E0B2eD310e29226fe16",
        "to": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E"
      }
    }
  },
  "strategies": {
    "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E": {
      "from": null,
      "to": {
        "address": "0xA6459195d60A797D278f58Ffbd2BA62Fb3F7FA1E",
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