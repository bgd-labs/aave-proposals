// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {COWSwapper} from './COWSwapper20230726.sol';

/**
 * @title Acquire more aUSDC for the treasury
 * @author Llama
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb4141f12f7ec8e037e6320912b5673fcc5909457d9f6201c018d5c15e5aa5083
 * - Discussion: https://governance.aave.com/t/arfc-deploy-ethereum-collector-contract/12205
 */
contract AaveV2_Eth_ServiceProviders_20231907 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  uint256 public constant AMOUNT_USDT = 974_000e6;
  uint256 public constant AMOUNT_DAI = 974_000e18;

  function execute() external {
    COWSwapper swapper = new COWSwapper();

    uint256 balance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.USDC_UNDERLYING, address(this), balance);

    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).forceApprove(address(AaveV2Ethereum.POOL), balance);
    AaveV2Ethereum.POOL.deposit(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      balance,
      address(AaveV2Ethereum.COLLECTOR),
      0
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      AMOUNT_USDT
    );
    AaveV2Ethereum.COLLECTOR.transfer(AaveV2EthereumAssets.DAI_A_TOKEN, address(this), AMOUNT_DAI);

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(swapper)
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(swapper)
    );

    swapper.swap();
  }
}
