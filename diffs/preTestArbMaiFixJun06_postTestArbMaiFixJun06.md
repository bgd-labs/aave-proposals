## Reserve changes

### Reserves altered

#### MAI ([0x3F56e0c36d275367b8C502090EDF38289b3dEa0d](https://arbiscan.io/address/0x3F56e0c36d275367b8C502090EDF38289b3dEa0d))

| description | value before | value after |
| --- | --- | --- |
| isFlashloanable | false | true |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://arbiscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) | [0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a](https://arbiscan.io/address/0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://arbiscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) | [0x5E76E98E0963EcDC6A065d1435F84065b7523f39](https://arbiscan.io/address/0x5E76E98E0963EcDC6A065d1435F84065b7523f39) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://arbiscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) | [0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7](https://arbiscan.io/address/0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7) |
| isPaused | true | false |


## Raw diff

```json
{
  "reserves": {
    "0x3F56e0c36d275367b8C502090EDF38289b3dEa0d": {
      "aTokenImpl": {
        "from": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "to": "0x1Be1798b70aEe431c2986f7ff48d9D1fa350786a"
      },
      "isFlashloanable": {
        "from": false,
        "to": true
      },
      "isPaused": {
        "from": true,
        "to": false
      },
      "stableDebtTokenImpl": {
        "from": "0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e",
        "to": "0x0c2C95b24529664fE55D4437D7A31175CFE6c4f7"
      },
      "variableDebtTokenImpl": {
        "from": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "to": "0x5E76E98E0963EcDC6A065d1435F84065b7523f39"
      }
    }
  }
}
```