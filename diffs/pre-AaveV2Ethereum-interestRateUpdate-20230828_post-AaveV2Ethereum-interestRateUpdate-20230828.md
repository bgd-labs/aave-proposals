## Reserve changes

### Reserves altered

#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | ![[0x04c28D6fE897859153eA753f986cc249Bf064f71](https://etherscan.io/address/0x04c28D6fE897859153eA753f986cc249Bf064f71)](/.assets/1_0x04c28D6fE897859153eA753f986cc249Bf064f71.svg) | ![[0x46158614537A48D51a30073A86b4B73B16D33b53](https://etherscan.io/address/0x46158614537A48D51a30073A86b4B73B16D33b53)](/.assets/1_0x46158614537A48D51a30073A86b4B73B16D33b53.svg) |
| baseVariableBorrowRate | 3 % | 5 % |
| variableRateSlope1 | 14 % | 22 % |
| stableRateSlope1 | 10 % | 22 % |
| stableRateSlope2 | 300 % | 150 % |


## Raw diff

```json
{
  "reserves": {
    "0xba100000625a3754423978a60c9317c58a424e3D": {
      "interestRateStrategy": {
        "from": "0x04c28D6fE897859153eA753f986cc249Bf064f71",
        "to": "0x46158614537A48D51a30073A86b4B73B16D33b53"
      }
    }
  },
  "strategies": {
    "0x46158614537A48D51a30073A86b4B73B16D33b53": {
      "from": null,
      "to": {
        "address": "0x46158614537A48D51a30073A86b4B73B16D33b53",
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