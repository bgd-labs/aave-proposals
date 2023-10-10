## Reserve changes

### Reserves altered

#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xF9336Bb69654fdd665AaC6618309a8cba078D8fE](https://optimistic.etherscan.io/address/0xF9336Bb69654fdd665AaC6618309a8cba078D8fE) | [0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326](https://optimistic.etherscan.io/address/0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326) |
| baseVariableBorrowRate | 1 % | 0 % |
| interestRate | ![before](/.assets/0503ddc95c9ff90b6308f1ba4175b90d670e81ed.svg) | ![after](/.assets/715cbb89cad22db0c20f074df5ed4b41cd5a2327.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000006": {
      "interestRateStrategy": {
        "from": "0xF9336Bb69654fdd665AaC6618309a8cba078D8fE",
        "to": "0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326"
      }
    }
  },
  "strategies": {
    "0x5f58C25D17C09c9e1892F45DE6dA45ed973A5326": {
      "from": null,
      "to": {
        "baseStableBorrowRate": "63000000000000000000000000",
        "baseVariableBorrowRate": 0,
        "maxExcessStableToTotalDebtRatio": "800000000000000000000000000",
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalStableToTotalDebtRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "40000000000000000000000000",
        "stableRateSlope2": "800000000000000000000000000",
        "variableRateSlope1": "33000000000000000000000000",
        "variableRateSlope2": "800000000000000000000000000"
      }
    }
  }
}
```