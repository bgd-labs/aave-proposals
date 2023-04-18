## Reserve changes

### Reserves altered

#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x04c28D6fE897859153eA753f986cc249Bf064f71](https://etherscan.io/address/0x04c28D6fE897859153eA753f986cc249Bf064f71) | [0x46158614537A48D51a30073A86b4B73B16D33b53](https://etherscan.io/address/0x46158614537A48D51a30073A86b4B73B16D33b53) |
| baseVariableBorrowRate | 3 % | 5 % |
| variableRateSlope1 | 14 % | 22 % |
| stableRateSlope1 | 10 % | 22 % |
| stableRateSlope2 | 300 % | 150 % |
| interestRate | ![before](/.assets/330013c26457182fd9217e67c8443bffe9a1b607.svg) | ![after](/.assets/6d918472bb221b9f32fa57a06095b6cfb1caa96e.svg) |

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