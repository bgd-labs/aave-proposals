---
title: Make USDT a collateral for Aave V3 ETH Pool
author: Marc Zeller (@marczeller - Aave Chan Initiative)
discussions: https://governance.aave.com/t/arfc-usdt-risk-parameters-update-aave-v3-eth-pool/13571
---

## Simple Summary

This ARFC proposes an update to the risk parameters for USDT in the Aave ETH V3 pool, enabling it as collateral.

## Motivation

This proposal aims to unlock the potential of USDT as collateral within the Aave ETH V3 pool. By aligning the risk parameters of USDT with those of USDC, we anticipate an increase in borrowing power for users. This change is expected to stimulate borrowing volume on Aave, thereby contributing to the protocol’s revenue. The activation of collateral power for USDT is a strategic move towards creating a more dynamic, efficient, and profitable liquidity environment within the Aave ETH V3 pool.

## Specification

Ticker: USDT

Contract Address: [0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7)`

### new Risk Parameters

| Parameter                | Value |
| :----------------------- | :---- |
| Loan to Value            | 74%   |
| Liquidation threshold    | 76%   |
| Liquidation bonus        | 4.5%  |
| Liquidation Protocol Fee | 10 %  |

## References

- Implementation: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_AaveV3USDTRiskParams_20231107/AaveV3_Eth_AaveV3USDTRiskParams_20231107.sol)
- Tests: [Ethereum](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV3_Eth_AaveV3USDTRiskParams_20231107/AaveV3_Eth_AaveV3USDTRiskParams_20231107.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x3690a2555731c402ac5dbcd225bdbc64f0bd11991d4d391d2682eb77b5dfa2a6)
- [Discussion](https://governance.aave.com/t/arfc-usdt-risk-parameters-update-aave-v3-eth-pool/13571)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
