## Reserve changes

### Reserves altered

#### GHO ([0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x16E77D8a7192b65fEd49B3374417885Ff4421A74](https://etherscan.io/address/0x16E77D8a7192b65fEd49B3374417885Ff4421A74) | [0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276](https://etherscan.io/address/0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276) |
| maxExcessUsageRatio | 0 % | 100 % |
| baseVariableBorrowRate | 1.5 % | 2.5 % |
| maxExcessStableToTotalDebtRatio | 0 % | 100 % |
| interestRate | ![before](/.assets/c3f99efc1151e69157cc7cfbea0481022427ae70.svg) | ![after](/.assets/e735d002641243988be9eaba1df5ef8adeb753ce.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f": {
      "interestRateStrategy": {
        "from": "0x16E77D8a7192b65fEd49B3374417885Ff4421A74",
        "to": "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276"
      }
    }
  },
  "strategies": {
    "0xA901Bf68Bebde17ba382e499C3e9EbAe649DF276": {
      "from": null,
      "to": {
        "baseStableBorrowRate": 0,
        "baseVariableBorrowRate": "25000000000000000000000000",
        "maxExcessStableToTotalDebtRatio": "1000000000000000000000000000",
        "maxExcessUsageRatio": "1000000000000000000000000000",
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