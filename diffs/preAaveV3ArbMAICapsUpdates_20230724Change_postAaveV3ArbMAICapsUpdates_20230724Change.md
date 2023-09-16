## Reserve changes

### Reserves altered

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 4,800,000 MAI | 325,000 MAI |
| borrowCap | 2,400,000 MAI | 250,000 MAI |
| debtCeiling | 1,200,000 $ | 100,000 $ |


## Raw diff

```json
{
  "reserves": {
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "borrowCap": {
        "from": 2400000,
        "to": 250000
      },
      "debtCeiling": {
        "from": 120000000,
        "to": 10000000
      },
      "supplyCap": {
        "from": 4800000,
        "to": 325000
      }
    }
  }
}
```