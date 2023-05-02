// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IMilkman} from './interfaces/IMilkman.sol';

import {COWTrader} from './COWTrader.sol';

contract SwapFor80BAL20WETHPayload is IProposalGenericExecutor {
  error AlreadyExecuted();

  uint256 public constant WETH_AMOUNT = 338_10e16; //338.10 aWETH

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
  address public constant aUSDTV1 = 0x71fc860F7D3A592A4a98740e39dB31d25db65ae8;
  uint256 public constant AMOUNT_AUSDT = 812_944_900000; // $812,944.90

  COWTrader internal trader;

  function execute() external {
    /*******************************************************************************
     ********************************* AGD Approval *********************************
     *******************************************************************************/

    AaveV2Ethereum.COLLECTOR.approve(aUSDTV1, AGD_MULTISIG, 0);
    AaveV2Ethereum.COLLECTOR.approve(AaveV2EthereumAssets.USDT_A_TOKEN, AGD_MULTISIG, AMOUNT_AUSDT);

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

    trader = new COWTrader();

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
