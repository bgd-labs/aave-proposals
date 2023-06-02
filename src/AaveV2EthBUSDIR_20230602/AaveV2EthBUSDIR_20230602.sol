// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title [ARFC] BUSD Offboarding Plan
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe2393893421edc01915de463cbf517086c1f6a4e84f54fdba2ed163334178a2f
 * - Discussion: https://governance.aave.com/t/arfc-busd-offboarding-plan-part-ii/13048
 */
contract AaveV2EthBUSDIR_20230602 is IProposalGenericExecutor {
  address public constant INTEREST_RATE_STRATEGY = 0xB28cA2760001c9837430F20c50fD89Ed56A449f0;
  uint256 public constant MAX_INT = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe; 

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      MAX_INT,
      address(AaveV2Ethereum.COLLECTOR)
    );
  }
}