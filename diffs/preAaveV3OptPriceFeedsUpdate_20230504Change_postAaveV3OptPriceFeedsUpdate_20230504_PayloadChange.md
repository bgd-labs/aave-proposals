## Reserve changes

### Reserves altered

#### wstETH ([0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x698B585CbC4407e2D54aa898B2600B53C68958f7](https://optimistic.etherscan.io/address/0x698B585CbC4407e2D54aa898B2600B53C68958f7) | [0x05225Cd708bCa9253789C1374e4337a019e99D56](https://optimistic.etherscan.io/address/0x05225Cd708bCa9253789C1374e4337a019e99D56) |
| oracleName | null | wstETH/ETH/USD |
| oracleLatestAnswer | 2086.4025 | 2085.77229659 |


## Raw diff

```json
{
  "poolConfig": {
    "priceOracleSentinel": {
      "from": "0x0000000000000000000000000000000000000000",
      "to": "0xB1ba0787Ca0A45f086F8CA03c97E7593636E47D5"
    }
  },
  "reserves": {
    "0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb": {
      "oracle": {
        "from": "0x698B585CbC4407e2D54aa898B2600B53C68958f7",
        "to": "0x05225Cd708bCa9253789C1374e4337a019e99D56"
      },
      "oracleLatestAnswer": {
        "from": 208640250000,
        "to": 208577229659
      },
      "oracleName": {
        "from": null,
        "to": "wstETH/ETH/USD"
      }
    }
  }
}
```