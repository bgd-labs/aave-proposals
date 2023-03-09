// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title [ARFC] BUSD Offboarding Plan
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xa3e30b1dcba6c3b5d618cff5ee7e8b68977e7d3a1677d55d6142c0438bdd0e8f
 * - Discussion: https://governance.aave.com/t/arfc-busd-offboarding-plan/12170
 */
contract AaveV2BUSDPayload is IProposalGenericExecutor {
  address public constant INTEREST_RATE_STRATEGY = 0x67a81df2b7FAf4a324D94De9Cc778704F4500478;
  uint256 public constant RESERVE_FACTOR = 99_90;

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      RESERVE_FACTOR
    );
  }
}
