## Reserve changes

### Reserves altered

#### MAI ([0xdFA46478F9e5EA86d57387849598dbFB2e964b02](https://optimistic.etherscan.io/address/0xdFA46478F9e5EA86d57387849598dbFB2e964b02))

| description | value before | value after |
| --- | --- | --- |
| isFlashloanable | false | true |
| aTokenImpl | [0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B](https://optimistic.etherscan.io/address/0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B) | [0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B](https://optimistic.etherscan.io/address/0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B) |
| variableDebtTokenImpl | [0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3](https://optimistic.etherscan.io/address/0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3) | [0x04a8D477eE202aDCE1682F5902e1160455205b12](https://optimistic.etherscan.io/address/0x04a8D477eE202aDCE1682F5902e1160455205b12) |
| stableDebtTokenImpl | [0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e](https://optimistic.etherscan.io/address/0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e) | [0x6b4E260b765B3cA1514e618C0215A6B7839fF93e](https://optimistic.etherscan.io/address/0x6b4E260b765B3cA1514e618C0215A6B7839fF93e) |
| isPaused | true | false |


## Raw diff

```json
{
  "reserves": {
    "0xdFA46478F9e5EA86d57387849598dbFB2e964b02": {
      "aTokenImpl": {
        "from": "0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B",
        "to": "0xbCb167bDCF14a8F791d6f4A6EDd964aed2F8813B"
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
        "to": "0x6b4E260b765B3cA1514e618C0215A6B7839fF93e"
      },
      "variableDebtTokenImpl": {
        "from": "0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3",
        "to": "0x04a8D477eE202aDCE1682F5902e1160455205b12"
      }
    }
  }
}
```