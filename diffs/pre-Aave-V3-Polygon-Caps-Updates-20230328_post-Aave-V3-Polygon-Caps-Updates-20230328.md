## Reserve changes

### Reserve altered

#### WMATIC ([0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 47,000,000 WMATIC | 66,000,000 WMATIC |


#### BAL ([0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 256,140 BAL | 290,000 BAL |


## Raw diff

```json
{
  "reserves": {
    "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270": {
      "supplyCap": {
        "from": 47000000,
        "to": 66000000
      }
    },
    "0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3": {
      "borrowCap": {
        "from": 256140,
        "to": 290000
      }
    }
  }
}
```