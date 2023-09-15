## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x16E77D8a7192b65fEd49B3374417885Ff4421A74](https://etherscan.io/address/0x16E77D8a7192b65fEd49B3374417885Ff4421A74) | [0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA](https://etherscan.io/address/0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA) |
| baseVariableBorrowRate | 1.5 % | 2.5 % |
| interestRate | ![before](/.assets/c3f99efc1151e69157cc7cfbea0481022427ae70.svg) | ![after](/.assets/66aa72f6fe3716b9b6a43abb25a455671672849e.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x16E77D8a7192b65fEd49B3374417885Ff4421A74",
        "to": "0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA"
      }
    }
  },
  "strategies": {
    "0x9210E5477dCA5bdF579ef0E1Ae84F9E823a5A3bA": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "25000000000000000000000000",
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