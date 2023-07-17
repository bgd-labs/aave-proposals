## Reserve changes

### Reserve altered

#### wstETH ([0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb))

| description | value before | value after |
| --- | --- | --- |
| eModeCategory | 0 | 2 |
| eMode.label | - | ETH correlated |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 93 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.priceSource | - | 0x0000000000000000000000000000000000000000 |


#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| eModeCategory | 0 | 2 |
| eMode.label | - | ETH correlated |
| eMode.ltv | - | 90 % |
| eMode.liquidationThreshold | - | 93 % |
| eMode.liquidationBonus | - | 1 % |
| eMode.priceSource | - | 0x0000000000000000000000000000000000000000 |


## Raw diff

```json
{
  "eModes": {
    "2": {
      "from": null,
      "to": {
        "eModeCategory": 2,
        "label": "ETH correlated",
        "liquidationBonus": 10100,
        "liquidationThreshold": 9300,
        "ltv": 9000,
        "priceSource": "0x0000000000000000000000000000000000000000"
      }
    }
  },
  "reserves": {
    "0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb": {
      "eModeCategory": {
        "from": 0,
        "to": 2
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "eModeCategory": {
        "from": 0,
        "to": 2
      }
    }
  }
}
```