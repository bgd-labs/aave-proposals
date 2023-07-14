## Reserve changes

### Reserves altered

#### USDT ([0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7))

| description | value before | value after |
| --- | --- | --- |
| usageAsCollateralEnabled | false | true |
| ltv | 0 % | 74 % |
| liquidationThreshold | 0 % | 76 % |
| liquidationBonus | 0 % | 4.5 % |
| liquidationProtocolFee | 0 % | 10 % |


## Raw diff

```json
{
  "reserves": {
    "0xdAC17F958D2ee523a2206206994597C13D831ec7": {
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
        "to": 7600
      },
      "ltv": {
        "from": 0,
        "to": 7400
      },
      "usageAsCollateralEnabled": {
        "from": false,
        "to": true
      }
    }
  }
}
```