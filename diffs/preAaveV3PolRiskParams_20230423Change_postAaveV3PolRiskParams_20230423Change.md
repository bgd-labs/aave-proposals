## Reserve changes

### Reserve altered

#### WMATIC ([0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % | 68 % |
| liquidationThreshold | 70 % | 73 % |
| liquidationBonus | 10 % | 7 % |


#### WBTC ([0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % | 73 % |
| liquidationThreshold | 75 % | 78 % |


#### LINK ([0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39](https://polygonscan.com/address/0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % | 53 % |
| liquidationThreshold | 65 % | 68 % |


#### DAI ([0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 76 % |
| liquidationThreshold | 80 % | 81 % |


## Raw diff

```json
{
  "reserves": {
    "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270": {
      "liquidationBonus": {
        "from": 11000,
        "to": 10700
      },
      "liquidationThreshold": {
        "from": 7000,
        "to": 7300
      },
      "ltv": {
        "from": 6500,
        "to": 6800
      }
    },
    "0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6": {
      "liquidationThreshold": {
        "from": 7500,
        "to": 7800
      },
      "ltv": {
        "from": 7000,
        "to": 7300
      }
    },
    "0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39": {
      "liquidationThreshold": {
        "from": 6500,
        "to": 6800
      },
      "ltv": {
        "from": 5000,
        "to": 5300
      }
    },
    "0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 8100
      },
      "ltv": {
        "from": 7500,
        "to": 7600
      }
    }
  }
}
```