## Reserve changes

### Reserves altered

#### MAI ([0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b](https://snowtrace.io/address/0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 700,000 MAI | 20,000 MAI |
| borrowCap | 460,000 MAI | 10,000 MAI |
| debtCeiling | 2,000,000 $ | 10,000 $ |


## Raw diff

```json
{
  "reserves": {
    "0x5c49b268c9841AFF1Cc3B0a418ff5c3442eE3F3b": {
      "borrowCap": {
        "from": 460000,
        "to": 10000
      },
      "debtCeiling": {
        "from": 200000000,
        "to": 1000000
      },
      "supplyCap": {
        "from": 700000,
        "to": 20000
      }
    }
  }
}
```