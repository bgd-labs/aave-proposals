---
title: v2 Deprecation Plan, 2023.10.03
author: Gauntlet, Chaos Labs
discussions: https://governance.aave.com/t/arfc-v2-ethereum-deprecation-10-03-2023/15040
---

## Summary

Following the [v2 deprecation framework](https://governance.aave.com/t/arfc-aave-v2-markets-deprecation-plan/14870), Gauntlet and Chaos recommend the following parameter changes to frozen assets on Aave v2 Ethereum.


## Specification

| Asset  | Current LT | Rec LT | Current LTV | Rec LTV |
|--------|--------|--------|-------------|---------|
| 1INCH  | 40%    | 24%    | 30%         | 0       |
| BAL    | 35%    | 25%    | 0           | 0       |
| BAT    | 40%    | 1%     | 0           | 0       |
| CRV    | 45%    | 42%    | 0           | 0       |
| CVX    | 35%    | 33%    | 0           | 0       |
| DPI    | 42%    | 16%    | 0           | 0       |
| ENJ    | 52%    | 50%    | 0           | 0       |
| ENS    | 52%    | 50%    | 42%         | 0       |
| LINK   | 83%    | 82%    | 70%         | 0       |
| MANA   | 54%    | 48%    | 0           | 0       |
| MKR    | 50%    | 35%    | 45%         | 0       |
| REN    | 32%    | 27%    | 0           | 0       |
| SNX    | 49%    | 43%    | 36%         | 0       |
| UNI    | 70%    | 70%    | 58%         | 0       |
| xSUSHI | 57%    | 28%    | 0           | 0       |
| YFI    | 50%    | 45%    | 0           | 0       |
| ZRX    | 42%    | 37%    | 0           | 0       |


## Implementation

The proposal implements changes using the following payloads:
  - [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/24c7c4e298c8ae7df15f4b0480b978ec1fce35f1/src/AaveV2Update_20231009/AaveV2Ethereum_20231009.sol)
  - [Ethereum Tests](https://github.com/bgd-labs/aave-proposals/blob/24c7c4e298c8ae7df15f4b0480b978ec1fce35f1/src/AaveV2Update_20231009/AaveV2Update_20231009_Test.t.sol)

## References

- **Discussion**: https://governance.aave.com/t/arfc-v2-ethereum-deprecation-10-03-2023/15040

## Disclaimer

Gauntlet and Chaos have not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

*By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos.*
