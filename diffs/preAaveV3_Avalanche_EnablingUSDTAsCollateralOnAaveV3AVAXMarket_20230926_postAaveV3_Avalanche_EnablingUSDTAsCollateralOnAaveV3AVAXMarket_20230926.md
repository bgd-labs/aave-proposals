## Reserve changes

### Reserves altered

#### USDt ([0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowtrace.io/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 200,000,000 USDt | 100,000,000 USDt |
| borrowCap | 140,000,000 USDt | 80,000,000 USDt |
| debtCeiling | 5,000,000 $ | 0 $ |
| ltv | 75 % | 82.25 % |
| liquidationThreshold | 81 % | 86.25 % |
| liquidationBonus | 5 % | 4 % |


## Raw diff

```json
{
  "reserves": {
    "0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7": {
      "borrowCap": {
        "from": 140000000,
        "to": 80000000
      },
      "debtCeiling": {
        "from": 500000000,
        "to": 0
      },
      "liquidationBonus": {
        "from": 10500,
        "to": 10400
      },
      "liquidationThreshold": {
        "from": 8100,
        "to": 8625
      },
      "ltv": {
        "from": 7500,
        "to": 8225
      },
      "supplyCap": {
        "from": 200000000,
        "to": 100000000
      }
    }
  }
}
```