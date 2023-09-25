## Reserve changes

### Reserves altered

#### OP ([0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042))

| description | value before | value after |
| --- | --- | --- |
| borrowCap | 0 OP | 500,000 OP |
| debtCeiling | 2,000,000 $ | 0 $ |
| interestRateStrategy | [0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C](https://optimistic.etherscan.io/address/0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C) | [0x3B57B081dA6Af5e2759A57bD3211932Cb6176997](https://optimistic.etherscan.io/address/0x3B57B081dA6Af5e2759A57bD3211932Cb6176997) |
| baseStableBorrowRate | 9 % | 10 % |
| stableRateSlope1 | 0 % | 13 % |
| stableRateSlope2 | 0 % | 300 % |
| interestRate | ![before](/.assets/19b2f23d55d76d891e7d30c29aa97741efed9d17.svg) | ![after](/.assets/eda3aded0333ece535adb2c0df7f1b16add284a2.svg) |

## Raw diff

```json
{
  "reserves": {
    "0x4200000000000000000000000000000000000042": {
      "borrowCap": {
        "from": 0,
        "to": 500000
      },
      "debtCeiling": {
        "from": 200000000,
        "to": 0
      },
      "interestRateStrategy": {
        "from": "0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C",
        "to": "0x3B57B081dA6Af5e2759A57bD3211932Cb6176997"
      }
    }
  }
}
```