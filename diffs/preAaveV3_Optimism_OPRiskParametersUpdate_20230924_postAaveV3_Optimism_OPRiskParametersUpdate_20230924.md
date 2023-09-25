## Reserve changes

### Reserves altered

#### OP ([0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042))

| description | value before | value after |
| --- | --- | --- |
| debtCeiling | 2,000,000 $ | 0 $ |
| interestRateStrategy | [0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C](https://optimistic.etherscan.io/address/0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C) | [0xF9336Bb69654fdd665AaC6618309a8cba078D8fE](https://optimistic.etherscan.io/address/0xF9336Bb69654fdd665AaC6618309a8cba078D8fE) |
| baseStableBorrowRate | 9 % | 10 % |
| stableRateSlope1 | 0 % | 7 % |
| stableRateSlope2 | 0 % | 300 % |
| interestRate | ![before](/.assets/19b2f23d55d76d891e7d30c29aa97741efed9d17.svg) | ![after](/.assets/f53061ad591928ed7724d8cc1b5b5c591c44943a.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000042": {
      "debtCeiling": {
        "from": 200000000,
        "to": 0
      },
      "interestRateStrategy": {
        "from": "0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C",
        "to": "0xF9336Bb69654fdd665AaC6618309a8cba078D8fE"
      }
    }
  },
  "strategies": {
    "0xF9336Bb69654fdd665AaC6618309a8cba078D8fE": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "100000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "550000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "450000000000000000000000000",
        "stableRateSlope1": "70000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "70000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    }
  }
}
```