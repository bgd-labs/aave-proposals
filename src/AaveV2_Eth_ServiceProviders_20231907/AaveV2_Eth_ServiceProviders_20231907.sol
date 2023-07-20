// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Bridge and deposit funds into aUSDC v2
 * @author Llama
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2_Eth_ServiceProviders_20231907 is IProposalGenericExecutor {
  function execute() external {
    uint256 balance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.USDC_UNDERLYING, address(this), balance);

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).approve(address(AaveV2Ethereum.POOL), balance);
    AaveV2Ethereum.POOL.deposit(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      balance,
      address(AaveV2Ethereum.COLLECTOR),
      0
    );
  }
}
