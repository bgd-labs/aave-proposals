// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AcquireRETHandWSTETH} from './AcquireRETHandWSTETH.sol';

/**
 * @title Acquire wstETH and rETH
 * @author Llama
 * @dev This proposal swaps aWETH holdings for wstETH and rETH
 * Governance: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205/4
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5bcb6dddf3e65597db2f0e8300edca5737788fcf6c63ca90024a8b4e685b40fe
 */
contract AaveV3StrategicAssets_20220622Payload is IProposalGenericExecutor {
  function execute() external {
    AcquireRETHandWSTETH acquire = new AcquireRETHandWSTETH();

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      1_400e18
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      address(this),
      200e18
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(acquire)
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(acquire)
    );

    acquire.swap();
  }
}
