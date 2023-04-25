// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IMilkman} from './interfaces/IMilkman.sol';

contract SwapFor80BAL20WETHPayload is IProposalGenericExecutor {
  error AlreadyExecuted();

  bool public executed;
  uint256 public constant WETH_AMOUNT = 338_10e16; //326.31 aWETH
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xFcd1726Cf48614E40E1f8EC636aC73bA05A52cF2;
  address public constant BAL80WETH20 = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
  address public constant aUSDTV1 = 0x71fc860F7D3A592A4a98740e39dB31d25db65ae8;
  uint256 public constant AMOUNT_AUSDT = 812_944_900000; // $812,944.90

  function execute() external {
    if (executed) revert AlreadyExecuted();
    executed = true;

    /*******************************************************************************
    ********************************* AGD Approval *********************************
    *******************************************************************************/

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      AaveV2Ethereum.COLLECTOR,
      aUSDTV1,
      AGD_MULTISIG,
      0
    );

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      AGD_MULTISIG,
      AMOUNT_AUSDT
    );

    /*******************************************************************************
    ******************************* Withdraw aTokens *******************************
    *******************************************************************************/

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      WETH_AMOUNT
    );

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.BAL_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(AaveV2Ethereum.COLLECTOR)
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      AaveV2Ethereum.COLLECTOR
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      type(uint256).max,
      AaveV2Ethereum.COLLECTOR
    );

    /*******************************************************************************
    *********************************** Approve ************************************
    *******************************************************************************/

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.WETH_UNDERLYING,
      MILKMAN,
      WETH_AMOUNT
    );

    AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.approve(
      AaveV2Ethereum.COLLECTOR,
      AaveV2EthereumAssets.BAL_UNDERLYING,
      MILKMAN,
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(AaveV2Ethereum.COLLECTOR)
    );

    /*******************************************************************************
    ************************************ Trade *************************************
    *******************************************************************************/

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      WETH_AMOUNT,
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
      IERC20(BAL80WETH20),
      AaveV2Ethereum.COLLECTOR,
      PRICE_CHECKER,
      abi.encode(200) // 2% slippage
    );

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(AaveV2Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
      IERC20(BAL80WETH20),
      AaveV2Ethereum.COLLECTOR,
      PRICE_CHECKER,
      abi.encode(200) // 2% slippage
    );
  }
}
