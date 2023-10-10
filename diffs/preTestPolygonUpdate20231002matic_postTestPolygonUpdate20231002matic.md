## Reserve changes

### Reserve altered

#### stMATIC ([0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4](https://polygonscan.com/address/0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % | 45 % |
| liquidationThreshold | 65 % | 60 % |


#### MaticX ([0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6](https://polygonscan.com/address/0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 58 % | 45 % |
| liquidationThreshold | 67 % | 62 % |


## Raw diff

```json
{
  "reserves": {
    "0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4": {
      "liquidationThreshold": {
        "from": 6500,
        "to": 6000
      },
      "ltv": {
        "from": 5000,
        "to": 4500
      }
    },
    "0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6": {
      "liquidationThreshold": {
        "from": 6700,
        "to": 6200
      },
      "ltv": {
        "from": 5800,
        "to": 4500
      }
    }
  }
}
```