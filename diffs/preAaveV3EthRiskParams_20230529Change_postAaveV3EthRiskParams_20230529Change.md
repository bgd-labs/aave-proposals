## Reserve changes

### Reserve altered

#### WBTC ([0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % | 73 % |
| liquidationThreshold | 75 % | 78 % |
| liquidationBonus | 6.25 % | 5 % |


#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % | 53 % |
| liquidationThreshold | 65 % | 68 % |
| liquidationBonus | 7.5 % | 7 % |


#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| ltv | 64 % | 67 % |
| liquidationThreshold | 77 % | 80 % |


#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 68.5 % | 69 % |
| liquidationThreshold | 79.5 % | 80 % |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| ltv | 74 % | 77 % |
| liquidationThreshold | 76 % | 79 % |


#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| ltv | 80 % | 80.5 % |
| liquidationThreshold | 82.5 % | 83 % |


## Raw diff

```json
{
  "reserves": {
    "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599": {
      "liquidationBonus": {
        "from": 10625,
        "to": 10500
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
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "liquidationBonus": {
        "from": 10750,
        "to": 10700
      },
      "liquidationThreshold": {
        "from": 6500,
        "to": 6800
      },
      "ltv": {
        "from": 5000,
        "to": 5300
      }
    },
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "liquidationThreshold": {
        "from": 7700,
        "to": 8000
      },
      "ltv": {
        "from": 6400,
        "to": 6700
      }
    },
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "liquidationThreshold": {
        "from": 7950,
        "to": 8000
      },
      "ltv": {
        "from": 6850,
        "to": 6900
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "liquidationThreshold": {
        "from": 7600,
        "to": 7900
      },
      "ltv": {
        "from": 7400,
        "to": 7700
      }
    },
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "liquidationThreshold": {
        "from": 8250,
        "to": 8300
      },
      "ltv": {
        "from": 8000,
        "to": 8050
      }
    }
  }
}
```