## Reserve changes

### Reserve altered

#### WMATIC ([0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270](https://polygonscan.com/address/0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x78Fe5d0427E669ba9F964C3495fF381a805a0487](https://polygonscan.com/address/0x78Fe5d0427E669ba9F964C3495fF381a805a0487) | [0x893411580e590D62dDBca8a703d61Cc4A8c7b2b9](https://polygonscan.com/address/0x893411580e590D62dDBca8a703d61Cc4A8c7b2b9) |
| interestRate | ![before](/.assets/d623b05c15166363301aacb46d7c2c761da0487f.svg) | ![after](/.assets/d623b05c15166363301aacb46d7c2c761da0487f.svg) |

#### WBTC ([0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x142DCAEC322aAA25141B2597bf348487aDBd596d](https://polygonscan.com/address/0x142DCAEC322aAA25141B2597bf348487aDBd596d) | [0x1d41b83e5bdbB21c4dD924507cBde66CD865d029](https://polygonscan.com/address/0x1d41b83e5bdbB21c4dD924507cBde66CD865d029) |
| interestRate | ![before](/.assets/9024b25803beaac85c9e1e00e50e08c212c3d6ee.svg) | ![after](/.assets/9024b25803beaac85c9e1e00e50e08c212c3d6ee.svg) |

#### WETH ([0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619](https://polygonscan.com/address/0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0x492dcEF1fc5253413fC5576B9522840a1A774DCe](https://polygonscan.com/address/0x492dcEF1fc5253413fC5576B9522840a1A774DCe) | [0xD792a3779D3C80bAEe8CF3304D6aEAc74bC432BE](https://polygonscan.com/address/0xD792a3779D3C80bAEe8CF3304D6aEAc74bC432BE) |
| interestRate | ![before](/.assets/109889a4fe0e3bcfce871de154c889a0ff8e0e94.svg) | ![after](/.assets/109889a4fe0e3bcfce871de154c889a0ff8e0e94.svg) |

#### USDT ([0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F))

| description | value before | value after |
| --- | --- | --- |
| interestRateStrategy | [0xF4d1352b3E9E99FCa6Aa20F62Fe95192A26C9527](https://polygonscan.com/address/0xF4d1352b3E9E99FCa6Aa20F62Fe95192A26C9527) | [0xD2C92b5A793e196aB11dBefBe3Af6BddeD6c3DD5](https://polygonscan.com/address/0xD2C92b5A793e196aB11dBefBe3Af6BddeD6c3DD5) |
| interestRate | ![before](/.assets/2e987a4911a41c316461bd57acf38be5b6ae837b.svg) | ![after](/.assets/2e987a4911a41c316461bd57acf38be5b6ae837b.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270": {
      "interestRateStrategy": {
        "from": "0x78Fe5d0427E669ba9F964C3495fF381a805a0487",
        "to": "0x893411580e590D62dDBca8a703d61Cc4A8c7b2b9"
      }
    },
    "0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6": {
      "interestRateStrategy": {
        "from": "0x142DCAEC322aAA25141B2597bf348487aDBd596d",
        "to": "0x1d41b83e5bdbB21c4dD924507cBde66CD865d029"
      }
    },
    "0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619": {
      "interestRateStrategy": {
        "from": "0x492dcEF1fc5253413fC5576B9522840a1A774DCe",
        "to": "0xD792a3779D3C80bAEe8CF3304D6aEAc74bC432BE"
      }
    },
    "0xc2132D05D31c914a87C6611C10748AEb04B58e8F": {
      "interestRateStrategy": {
        "from": "0xF4d1352b3E9E99FCa6Aa20F62Fe95192A26C9527",
        "to": "0xD2C92b5A793e196aB11dBefBe3Af6BddeD6c3DD5"
      }
    }
  },
  "strategies": {
    "0x1d41b83e5bdbB21c4dD924507cBde66CD865d029": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "100000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    },
    "0x893411580e590D62dDBca8a703d61Cc4A8c7b2b9": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "100000000000000000000000000",
        "stableRateSlope2": "3000000000000000000000000000",
        "variableRateSlope1": "60000000000000000000000000",
        "variableRateSlope2": "3000000000000000000000000000"
      }
    },
    "0xD2C92b5A793e196aB11dBefBe3Af6BddeD6c3DD5": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "200000000000000000000000000",
        "optimalUsageRatio": "800000000000000000000000000",
        "stableRateSlope1": "20000000000000000000000000",
        "stableRateSlope2": "1000000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    },
    "0xD792a3779D3C80bAEe8CF3304D6aEAc74bC432BE": {
      "from": null,
      "to": {
        "baseVariableBorrowRate": 0,
        "maxExcessUsageRatio": "350000000000000000000000000",
        "optimalUsageRatio": "650000000000000000000000000",
        "stableRateSlope1": "100000000000000000000000000",
        "stableRateSlope2": "1000000000000000000000000000",
        "variableRateSlope1": "40000000000000000000000000",
        "variableRateSlope2": "1000000000000000000000000000"
      }
    }
  }
}
```