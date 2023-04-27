## Reserve changes

### Reserve altered

#### WBTC ([0x68f180fcCe6836688e9084f035309E29Bf0A2095](https://optimistic.etherscan.io/address/0x68f180fcCe6836688e9084f035309E29Bf0A2095))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % | 73 % |
| liquidationThreshold | 75 % | 78 % |
| liquidationBonus | 9.4 % | 8.5 % |


#### DAI ([0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1))

| description | value before | value after |
| --- | --- | --- |
| ltv | 75 % | 78 % |
| liquidationThreshold | 80 % | 83 % |


## Raw diff

```json
{
  "reserves": {
    "0x68f180fcCe6836688e9084f035309E29Bf0A2095": {
      "liquidationBonus": {
        "from": 10940,
        "to": 10850
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 7800
      },
      "ltv": {
        "from": 7000,
        "to": 7300
      }
    },
    "0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 8300
      },
      "ltv": {
        "from": 7500,
        "to": 7800
      }
    }
  }
}
```