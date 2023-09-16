## Reserve changes

### Reserves altered

#### miMATIC ([0xa3Fa99A148fA48D14Ed51d610c367C61876997F1](https://polygonscan.com/address/0xa3Fa99A148fA48D14Ed51d610c367C61876997F1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 2,200,000 miMATIC | 900,000 miMATIC |
| borrowCap | 1,200,000 miMATIC | 700,000 miMATIC |
| debtCeiling | 2,000,000 $ | 180,000 $ |


## Raw diff

```json
{
  "reserves": {
    "0xa3Fa99A148fA48D14Ed51d610c367C61876997F1": {
      "borrowCap": {
        "from": 1200000,
        "to": 700000
      },
      "debtCeiling": {
        "from": 200000000,
        "to": 18000000
      },
      "supplyCap": {
        "from": 2200000,
        "to": 900000
      }
    }
  }
}
```