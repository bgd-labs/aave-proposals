## Reserve changes

### Reserves altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 15 % | 25 % |
| stableBorrowRateEnabled | true | false |
| interestRateStrategy | [0xfffE32106A68aA3eD39CcCE673B646423EEaB62a](https://etherscan.io/address/0xfffE32106A68aA3eD39CcCE673B646423EEaB62a) | [0xc6A068E321C83FEacc25C80118E2B1208c54B6ce](https://etherscan.io/address/0xc6A068E321C83FEacc25C80118E2B1208c54B6ce) |
| optimalUsageRatio | 80 % | 90 % |
| maxExcessUsageRatio | 20 % | 10 % |
| variableRateSlope1 | 4 % | 5 % |
| interestRate | ![before](/.assets/c415a8c57745a62d63e11134fe8acf5059377542.svg) | ![after](/.assets/d1a493171bfb16a17ecaf7a2d7ef8e0782317be5.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "interestRateStrategy": {
        "from": "0xfffE32106A68aA3eD39CcCE673B646423EEaB62a",
        "to": "0xc6A068E321C83FEacc25C80118E2B1208c54B6ce"
      },
      "reserveFactor": {
        "from": 1500,
        "to": 2500
      },
      "stableBorrowRateEnabled": {
        "from": true,
        "to": false
      }
    }
  },
  "strategies": {
    "0xc6A068E321C83FEacc25C80118E2B1208c54B6ce": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "100000000000000000000000000",
        "optimalUsageRatio": "900000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "750000000000000000000000000",
        "variableRateSlope1": "50000000000000000000000000",
        "variableRateSlope2": "750000000000000000000000000"
      }
    }
  }
}
```