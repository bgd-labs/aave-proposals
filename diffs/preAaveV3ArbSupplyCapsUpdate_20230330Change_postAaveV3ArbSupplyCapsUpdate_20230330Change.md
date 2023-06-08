## Reserve changes

### Reserve altered

#### WBTC ([0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f](https://arbiscan.io/address/0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 2,100 WBTC | 4,200 WBTC |


#### WETH ([0x82aF49447D8a07e3bd95BD0d56f35241523fBab1](https://arbiscan.io/address/0x82aF49447D8a07e3bd95BD0d56f35241523fBab1))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 35,280 WETH | 70,000 WETH |
| borrowCap | 11,165 WETH | 22,000 WETH |


## Raw diff

```json
{
  "reserves": {
    "0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f": {
      "supplyCap": {
        "from": 2100,
        "to": 4200
      }
    },
    "0x82aF49447D8a07e3bd95BD0d56f35241523fBab1": {
      "borrowCap": {
        "from": 11165,
        "to": 22000
      },
      "supplyCap": {
        "from": 35280,
        "to": 70000
      }
    }
  }
}
```