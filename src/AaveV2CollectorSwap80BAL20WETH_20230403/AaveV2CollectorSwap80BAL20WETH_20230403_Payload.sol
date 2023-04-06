// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from 'solidity-utils/lib/forge-std/src/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IMilkman} from './interfaces/IMilkman.sol';

contract SwapFor80BAL20WETHPayload is IProposalGenericExecutor {
  error AlreadyExecuted();

  bool public executed;
  uint256 public constant WETH_AMOUNT = 326_31e16; //326.31 aWETH
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xf447Bf3CF8582E4DaB9c34C5b261A7b6AD4D6bDD;

  function execute() external {
    if (executed) revert AlreadyExecuted();
    executed = true;

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      WETH_AMOUNT
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).approve(MILKMAN, WETH_AMOUNT);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      WETH_AMOUNT,
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.BAL_UNDERLYING,
      AaveV2Ethereum.COLLECTOR,
      PRICE_CHECKER,
      priceCheckerData
    );
  }
}
