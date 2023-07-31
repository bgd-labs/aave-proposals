## Reserve changes

### Reserves altered

#### TUSD ([0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 0 % |
| liquidationThreshold | 77.5 % | 75 % |
| liquidationBonus | 5 % | 10 % |
| borrowingEnabled | true | false |
| stableBorrowRateEnabled | true | false |
| interestRateStrategy | [0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC](https://etherscan.io/address/0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC) | [0xB28cA2760001c9837430F20c50fD89Ed56A449f0](https://etherscan.io/address/0xB28cA2760001c9837430F20c50fD89Ed56A449f0) |
| optimalUsageRatio | 80 % | 2 % |
| maxExcessUsageRatio | 20 % | 98 % |
| baseVariableBorrowRate | 0 % | 3 % |
| variableRateSlope1 | 4 % | 7 % |
| variableRateSlope2 | 100 % | 300 % |
| stableRateSlope1 | 2 % | 7 % |
| stableRateSlope2 | 100 % | 3000 % |
| interestRate | ![before](/.assets/2e987a4911a41c316461bd57acf38be5b6ae837b.svg) | ![after](/.assets/caf95847460159571f7d6f0fbf09566915c5ca5b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0000000000085d4780B73119b644AE5ecd22b376": {
      "borrowingEnabled": {
        "from": true,
        "to": false
      },
      "interestRateStrategy": {
        "from": "0x6bcE15B789e537f3abA3C60CB183F0E8737f05eC",
        "to": "0xB28cA2760001c9837430F20c50fD89Ed56A449f0"
      },
      "liquidationBonus": {
        "from": 10500,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7750,
        "to": 7500
      },
      "ltv": {
        "from": 7500,
        "to": 0
      },
      "stableBorrowRateEnabled": {
        "from": true,
        "to": false
      }
    }
  }
}
```