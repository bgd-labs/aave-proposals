## Reserve changes

### Reserve altered

#### stMATIC ([0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4](https://polygonscan.com/address/0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x97371dF4492605486e23Da797fA68e55Fc38a13f](https://polygonscan.com/address/0x97371dF4492605486e23Da797fA68e55Fc38a13f) | [0xEe96b77129cF54581B5a8FECCcC50A6A067034a1](https://polygonscan.com/address/0xEe96b77129cF54581B5a8FECCcC50A6A067034a1) |
| oracleDescription | Calculated stMATIC / USD | stMATIC/MATIC/USD |
| oracleLatestAnswer | 0.9295516 | 0.92945817 |


#### MaticX ([0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6](https://polygonscan.com/address/0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x5d37E4b374E6907de8Fc7fb33EE3b0af403C7403](https://polygonscan.com/address/0x5d37E4b374E6907de8Fc7fb33EE3b0af403C7403) | [0x0e1120524e14Bd7aD96Ea76A1b1dD699913e2a45](https://polygonscan.com/address/0x0e1120524e14Bd7aD96Ea76A1b1dD699913e2a45) |
| oracleDescription | Calculated MaticX / USD | MATICX/MATIC/USD |
| oracleLatestAnswer | 0.92044176 | 0.92303148 |


## Raw diff

```json
{
  "reserves": {
    "0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4": {
      "oracle": {
        "from": "0x97371dF4492605486e23Da797fA68e55Fc38a13f",
        "to": "0xEe96b77129cF54581B5a8FECCcC50A6A067034a1"
      },
      "oracleDescription": {
        "from": "Calculated stMATIC / USD",
        "to": "stMATIC/MATIC/USD"
      },
      "oracleLatestAnswer": {
        "from": 92955160,
        "to": 92945817
      }
    },
    "0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6": {
      "oracle": {
        "from": "0x5d37E4b374E6907de8Fc7fb33EE3b0af403C7403",
        "to": "0x0e1120524e14Bd7aD96Ea76A1b1dD699913e2a45"
      },
      "oracleDescription": {
        "from": "Calculated MaticX / USD",
        "to": "MATICX/MATIC/USD"
      },
      "oracleLatestAnswer": {
        "from": 92044176,
        "to": 92303148
      }
    }
  }
}
```