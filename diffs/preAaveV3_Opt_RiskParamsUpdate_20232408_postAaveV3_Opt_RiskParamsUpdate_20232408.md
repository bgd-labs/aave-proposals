## Reserve changes

### Reserve altered

#### wstETH ([0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb))

| description          | value before | value after |
| -------------------- | ------------ | ----------- |
| ltv                  | 70 %         | 71 %        |
| liquidationThreshold | 79 %         | 80 %        |

#### WBTC ([0x68f180fcCe6836688e9084f035309E29Bf0A2095](https://optimistic.etherscan.io/address/0x68f180fcCe6836688e9084f035309E29Bf0A2095))

| description      | value before | value after |
| ---------------- | ------------ | ----------- |
| liquidationBonus | 8.5 %        | 7.5 %       |

## Raw diff

```json
{
  "reserves": {
    "0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb": {
      "liquidationThreshold": {
        "from": 7900,
        "to": 8000
      },
      "ltv": {
        "from": 7000,
        "to": 7100
      }
    },
    "0x68f180fcCe6836688e9084f035309E29Bf0A2095": {
      "liquidationBonus": {
        "from": 10850,
        "to": 10750
      }
    }
  }
}
```
