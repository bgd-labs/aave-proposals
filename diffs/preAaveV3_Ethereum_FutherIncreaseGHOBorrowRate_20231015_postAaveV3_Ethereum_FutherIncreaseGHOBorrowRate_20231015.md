## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA](https://etherscan.io/address/0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA) | [0x1255fC8DC8E76761995aCF544eea54f1B7fB0459](https://etherscan.io/address/0x1255fC8DC8E76761995aCF544eea54f1B7fB0459) |
| baseVariableBorrowRate | 2.5 % | 3 % |
| interestRate | ![before](/.assets/66aa72f6fe3716b9b6a43abb25a455671672849e.svg) | ![after](/.assets/014307f374497fc89005a570ba007728a33c0203.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA",
        "to": "0x1255fC8DC8E76761995aCF544eea54f1B7fB0459"
      }
    }
  },
  "strategies": {
    "0x1255fC8DC8E76761995aCF544eea54f1B7fB0459": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "30000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": 0,
        "maxExcessUsageRatio": 0,
        "optimalStableToTotalDebtRatio": 0,
        "optimalUsageRatio": 0,
        "stableRateSlope1": 0,
        "stableRateSlope2": 0,
        "variableRateSlope1": 0,
        "variableRateSlope2": 0
      }
    }
  }
}
```