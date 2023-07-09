## Reserve changes

### Reserves altered

#### FEI ([0x956F47F50A910163D8BF957Cf5846D573E7f87CA](https://etherscan.io/address/0x956F47F50A910163D8BF957Cf5846D573E7f87CA))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % | 0 % |
| liquidationThreshold | 75 % | 1 % |
| liquidationBonus | 6.5 % | 10 % |
| interestRateStrategy | [0xF0bA2a8c12A2354c075b363765EAe825619bd490](https://etherscan.io/address/0xF0bA2a8c12A2354c075b363765EAe825619bd490) | [0x795dC59EA6472Dfa4298A454C6E8Dcb005643A13](https://etherscan.io/address/0x795dC59EA6472Dfa4298A454C6E8Dcb005643A13) |
| optimalUsageRatio | 80 % | 1 % |
| maxExcessUsageRatio | 20 % | 99 % |
| interestRate | ![before](/.assets/2e987a4911a41c316461bd57acf38be5b6ae837b.svg) | ![after](/.assets/b10a47386e954467cec43720ed9cf782b044323c.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x956F47F50A910163D8BF957Cf5846D573E7f87CA": {
      "interestRateStrategy": {
        "from": "0xF0bA2a8c12A2354c075b363765EAe825619bd490",
        "to": "0x795dC59EA6472Dfa4298A454C6E8Dcb005643A13"
      },
      "liquidationBonus": {
        "from": 10650,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 100
      },
      "ltv": {
        "from": 6500,
        "to": 0
      }
    }
  },
  "strategies": {
    "0x795dC59EA6472Dfa4298A454C6E8Dcb005643A13": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "990000000000000000000000000",
        "optimalUsageRatio": "10000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1000000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    }
  }
}
```