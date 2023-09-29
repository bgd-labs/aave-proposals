## Reserve changes

### Reserve altered

#### sAVAX ([0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE](https://snowtrace.io/address/0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE))

| description | value before | value after |
| --- | --- | --- |
| ltv | 20 % | 30 % |
| liquidationThreshold | 30 % | 40 % |


#### LINK.e ([0x5947BB275c521040051D82396192181b413227A3](https://snowtrace.io/address/0x5947BB275c521040051D82396192181b413227A3))

| description | value before | value after |
| --- | --- | --- |
| ltv | 53 % | 56 % |
| liquidationThreshold | 68 % | 71 % |


#### WAVAX ([0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://snowtrace.io/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7))

| description | value before | value after |
| --- | --- | --- |
| liquidationBonus | 10 % | 9 % |


## Raw diff

```json
{
  "reserves": {
    "0x2b2C81e08f1Af8835a78Bb2A90AE924ACE0eA4bE": {
      "liquidationThreshold": {
        "from": 3000,
        "to": 4000
      },
      "ltv": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x5947BB275c521040051D82396192181b413227A3": {
      "liquidationThreshold": {
        "from": 6800,
        "to": 7100
      },
      "ltv": {
        "from": 5300,
        "to": 5600
      }
    },
    "0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7": {
      "liquidationBonus": {
        "from": 11000,
        "to": 10900
      }
    }
  }
}
```