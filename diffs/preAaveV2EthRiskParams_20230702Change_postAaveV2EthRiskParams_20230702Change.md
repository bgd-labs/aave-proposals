## Reserve changes

### Reserve altered

#### BAT ([0x0D8775F648430679A709E98d2b0Cb6250d2887EF](https://etherscan.io/address/0x0D8775F648430679A709E98d2b0Cb6250d2887EF))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % | 0 % |
| liquidationThreshold | 70 % | 52 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### MANA ([0x0F5D2fB29fb7d3CFeE444a200298f468908cC942](https://etherscan.io/address/0x0F5D2fB29fb7d3CFeE444a200298f468908cC942))

| description | value before | value after |
| --- | --- | --- |
| ltv | 61.5 % | 0 % |
| liquidationThreshold | 75 % | 62 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 35 % | 45 % |


#### YFI ([0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e](https://etherscan.io/address/0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % | 0 % |
| liquidationThreshold | 65 % | 55 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### DPI ([0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b](https://etherscan.io/address/0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % | 0 % |
| liquidationThreshold | 70 % | 42 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### REN ([0x408e41876cCCDC0F92210600ef50372656052a38](https://etherscan.io/address/0x408e41876cCCDC0F92210600ef50372656052a38))

| description | value before | value after |
| --- | --- | --- |
| ltv | 55 % | 0 % |
| liquidationThreshold | 60 % | 40 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### CVX ([0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B](https://etherscan.io/address/0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B))

| description | value before | value after |
| --- | --- | --- |
| ltv | 35 % | 0 % |
| liquidationThreshold | 45 % | 40 % |
| reserveFactor | 20 % | 30 % |


#### xSUSHI ([0x8798249c2E607446EfB7Ad49eC89dD1865Ff4272](https://etherscan.io/address/0x8798249c2E607446EfB7Ad49eC89dD1865Ff4272))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % | 0 % |
| liquidationThreshold | 65 % | 60 % |
| liquidationBonus | 8.5 % | 10 % |
| reserveFactor | 35 % | 45 % |


#### ZRX ([0xE41d2489571d322189246DaFA5ebDe1F4699F498](https://etherscan.io/address/0xE41d2489571d322189246DaFA5ebDe1F4699F498))

| description | value before | value after |
| --- | --- | --- |
| ltv | 55 % | 0 % |
| liquidationThreshold | 65 % | 45 % |
| liquidationBonus | 7.5 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### ENJ ([0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c](https://etherscan.io/address/0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % | 0 % |
| liquidationThreshold | 67 % | 60 % |
| liquidationBonus | 6 % | 10 % |
| reserveFactor | 20 % | 30 % |


#### BAL ([0xba100000625a3754423978a60c9317c58a424e3D](https://etherscan.io/address/0xba100000625a3754423978a60c9317c58a424e3D))

| description | value before | value after |
| --- | --- | --- |
| ltv | 65 % | 0 % |
| liquidationThreshold | 70 % | 55 % |
| reserveFactor | 20 % | 30 % |


#### KNC ([0xdd974D5C2e2928deA5F71b9825b8b646686BD200](https://etherscan.io/address/0xdd974D5C2e2928deA5F71b9825b8b646686BD200))

| description | value before | value after |
| --- | --- | --- |
| ltv | 60 % | 0 % |
| liquidationThreshold | 70 % | 1 % |
| reserveFactor | 20 % | 30 % |


## Raw diff

```json
{
  "reserves": {
    "0x0D8775F648430679A709E98d2b0Cb6250d2887EF": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7000,
        "to": 5200
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x0F5D2fB29fb7d3CFeE444a200298f468908cC942": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7500,
        "to": 6200
      },
      "ltv": {
        "from": 6150,
        "to": 0
      },
      "reserveFactor": {
        "from": 3500,
        "to": 4500
      }
    },
    "0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 6500,
        "to": 5500
      },
      "ltv": {
        "from": 5000,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x1494CA1F11D487c2bBe4543E90080AeBa4BA3C2b": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 7000,
        "to": 4200
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x408e41876cCCDC0F92210600ef50372656052a38": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 6000,
        "to": 4000
      },
      "ltv": {
        "from": 5500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B": {
      "liquidationThreshold": {
        "from": 4500,
        "to": 4000
      },
      "ltv": {
        "from": 3500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0x8798249c2E607446EfB7Ad49eC89dD1865Ff4272": {
      "liquidationBonus": {
        "from": 10850,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 6500,
        "to": 6000
      },
      "ltv": {
        "from": 5000,
        "to": 0
      },
      "reserveFactor": {
        "from": 3500,
        "to": 4500
      }
    },
    "0xE41d2489571d322189246DaFA5ebDe1F4699F498": {
      "liquidationBonus": {
        "from": 10750,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 6500,
        "to": 4500
      },
      "ltv": {
        "from": 5500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0xF629cBd94d3791C9250152BD8dfBDF380E2a3B9c": {
      "liquidationBonus": {
        "from": 10600,
        "to": 11000
      },
      "liquidationThreshold": {
        "from": 6700,
        "to": 6000
      },
      "ltv": {
        "from": 6000,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0xba100000625a3754423978a60c9317c58a424e3D": {
      "liquidationThreshold": {
        "from": 7000,
        "to": 5500
      },
      "ltv": {
        "from": 6500,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    },
    "0xdd974D5C2e2928deA5F71b9825b8b646686BD200": {
      "liquidationThreshold": {
        "from": 7000,
        "to": 100
      },
      "ltv": {
        "from": 6000,
        "to": 0
      },
      "reserveFactor": {
        "from": 2000,
        "to": 3000
      }
    }
  }
}
```