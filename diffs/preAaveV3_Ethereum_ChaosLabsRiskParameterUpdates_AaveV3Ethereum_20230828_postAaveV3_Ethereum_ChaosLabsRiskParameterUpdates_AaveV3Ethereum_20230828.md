## Reserve changes

### Reserve altered

#### DAI ([0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F))

| description | value before | value after |
| --- | --- | --- |
| liquidationBonus | 4 % | 5 % |


#### wstETH ([0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0))

| description | value before | value after |
| --- | --- | --- |
| ltv | 69 % | 78.5 % |
| liquidationThreshold | 80 % | 81 % |


#### cbETH ([0xBe9895146f7AF43049ca1c1AE358B0541Ea49704](https://etherscan.io/address/0xBe9895146f7AF43049ca1c1AE358B0541Ea49704))

| description | value before | value after |
| --- | --- | --- |
| ltv | 67 % | 74.5 % |
| liquidationThreshold | 74 % | 77 % |


#### rETH ([0xae78736Cd615f374D3085123A210448E74Fc6393](https://etherscan.io/address/0xae78736Cd615f374D3085123A210448E74Fc6393))

| description | value before | value after |
| --- | --- | --- |
| ltv | 67 % | 74.5 % |
| liquidationThreshold | 74 % | 77 % |


## Raw diff

```json
{
  "reserves": {
    "0x6B175474E89094C44Da98b954EedeAC495271d0F": {
      "liquidationBonus": {
        "from": 10400,
        "to": 10500
      }
    },
    "0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 8100
      },
      "ltv": {
        "from": 6900,
        "to": 7850
      }
    },
    "0xBe9895146f7AF43049ca1c1AE358B0541Ea49704": {
      "liquidationThreshold": {
        "from": 7400,
        "to": 7700
      },
      "ltv": {
        "from": 6700,
        "to": 7450
      }
    },
    "0xae78736Cd615f374D3085123A210448E74Fc6393": {
      "liquidationThreshold": {
        "from": 7400,
        "to": 7700
      },
      "ltv": {
        "from": 6700,
        "to": 7450
      }
    }
  }
}
```