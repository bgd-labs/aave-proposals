## Reserve changes

### Reserves altered

#### OP ([0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 0 OP | 500,000 OP |
| debtCeiling | 2,000,000 $ | 0 $ |


## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000042": {
      "borrowCap": {
        "from": 0,
        "to": 500000
      },
      "debtCeiling": {
        "from": 200000000,
        "to": 0
      }
    }
  }
}
```