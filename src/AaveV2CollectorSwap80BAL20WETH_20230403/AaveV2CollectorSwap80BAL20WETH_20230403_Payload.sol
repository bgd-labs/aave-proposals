// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import {console2} from 'forge-std/Test.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IMilkman} from './interfaces/IMilkman.sol';

import {COWTrader} from './COWTrader.sol';

contract SwapFor80BAL20WETHPayload is IProposalGenericExecutor {
  uint256 public constant WETH_AMOUNT = 338_10e16; //338.10 aWETH

  function execute() external {
    /*******************************************************************************
     ******************************* Withdraw aTokens *******************************
     *******************************************************************************/

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      WETH_AMOUNT
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BAL_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );

    /*******************************************************************************
     ********************************** Transfer ***********************************
     *******************************************************************************/

    COWTrader trader = new COWTrader();

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      address(trader),
      WETH_AMOUNT
    );

    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      address(trader),
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)
      )
    );

    trader.trade();
  }
}
