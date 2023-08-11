## Reserve changes

### Reserves altered

#### LUSD ([0x5f98805A4E8be255a32880FDeC7F6728C6568bA0](https://etherscan.io/address/0x5f98805A4E8be255a32880FDeC7F6728C6568bA0))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % | 77 % |
| liquidationThreshold | 0 % | 80 % |
| liquidationBonus | 0 % | 4.5 % |
| liquidationProtocolFee | 0 % | 10 % |


## Raw diff

```json
{
  "reserves": {
    "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0": {
      "liquidationBonus": {
        "from": 0,
        "to": 10450
      },
      "liquidationProtocolFee": {
        "from": 0,
        "to": 1000
      },
      "liquidationThreshold": {
        "from": 0,
        "to": 8000
      },
      "ltv": {
        "from": 0,
        "to": 7700
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  }
}
```