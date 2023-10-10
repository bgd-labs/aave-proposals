---
title: Gauntlet Recommendations to Lower WETH Variable Base to 0 on Arbitrum, Optimism v3
author: Paul Lei, Watson Fu, Nick Del Zingaro, Walter Li, Jonathan Reem, Nick Cannon, Sarah Chen, Dana Tung
discussions: https://governance.aave.com/t/gauntlet-interest-rate-recommendations-for-weth-and-wmatic-on-v2-and-v3/14588
---

## Summary

A proposal to make a followup to Gauntlet's previous WETH IR recommendations.

The community voted to pass option 1 on Gauntlet's previous snapshot, which lowered slope 1 for WETH on all v3 to 3.3%. On the other hand, option 2 recommended to remove the base rate for WETH to match v3 Ethereum.

Option 1 was intended to be a superset of option 2 and also intended to lower the base rate to 0 for WETH. This language was not specified in the snapshot. As a result, we only included lowering WETH slope 1 in AIP-327.

To be extra clear with the community, we put out this new AIP specifically for lowering the base rate to 0 for WETH. Given current borrowing profiles on v3, we decide to move forward with Arbitrum and Optimism v3.

Again, this will help to
- drive additional revenue to Aave.
- adjust current risk profile for LST to depend less on onchain liquidity, which has been steadily declining over the past few months. This may be adding risk to the current borrow composition against LST collateral.

## Specification

| Chain    | Asset | Action              | Current Value | New Value |
| -------- | ----- | ------------------- | ------------- | --------- |
| Optimism | WETH  | Lower Variable Base | 1%            | 0%        |
| Arbitrum | WETH  | Lower Variable Base | 1%            | 0%        |

## Implementation

The proposal implements changes on Optimism and Arbitrum v3 using the following payloads:

- [Optimism](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231002weth/AaveV3Optimism_20231002weth.sol)
- [Arbitrum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3Update_20231002weth/AaveV3Arbitrum_20231002weth.sol)

## References

- **Discussion**: https://governance.aave.com/t/gauntlet-interest-rate-recommendations-for-weth-and-wmatic-on-v2-and-v3/14588/8
- **Snapshot**: https://snapshot.org/#/aave.eth/proposal/0x38a04c265542ec82202b9bb22ef4548290fbe7cde068f7c1c4fa9cd67c3c491b

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
