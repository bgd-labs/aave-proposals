// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from "solidity-utils/contracts/oz-common/SafeERC20.sol";
import {IMilkman} from './interfaces/IMilkman.sol';

contract COWTrader {
  using SafeERC20 for IERC20;

  event TradeCanceled();
  event TradeRequested();

  error InvalidCaller();
  error PendingTrade();

  address public constant BAL80WETH20 = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xFcd1726Cf48614E40E1f8EC636aC73bA05A52cF2;
  address public constant ALLOWED_CALLER = 0x55B16934C3661E1990939bC57322554d9B09f262;
  bool trading;

  uint256 balBalance;
  uint256 wethBalance;

  function trade() external {
    if (trading) revert PendingTrade();
    trading = true;

    balBalance = IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(this));
    wethBalance = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this));

    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).approve(MILKMAN, wethBalance);
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).approve(MILKMAN, balBalance);

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      wethBalance,
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
      IERC20(BAL80WETH20),
      address(AaveV2Ethereum.COLLECTOR),
      PRICE_CHECKER,
      abi.encode(50) // 0.5% slippage
    );

    IMilkman(MILKMAN).requestSwapExactTokensForTokens(
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING),
      IERC20(BAL80WETH20),
      address(AaveV2Ethereum.COLLECTOR),
      PRICE_CHECKER,
      abi.encode(50) // 0.5% slippage
    );

    emit TradeRequested();
  }

  function cancelTrades() external {
    if (msg.sender != ALLOWED_CALLER) revert InvalidCaller();

    IMilkman(MILKMAN).cancelSwap(
      wethBalance,
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING),
      IERC20(BAL80WETH20),
      address(AaveV2Ethereum.COLLECTOR),
      PRICE_CHECKER,
      abi.encode(50) // 0.5% slippage
    );

    IMilkman(MILKMAN).cancelSwap(
      balBalance,
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING),
      IERC20(BAL80WETH20),
      address(AaveV2Ethereum.COLLECTOR),
      PRICE_CHECKER,
      abi.encode(50) // 0.5% slippage
    );

    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).safeTransfer(
      address(AaveV2Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).safeTransfer(
      address(AaveV2Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.BAL_UNDERLYING).balanceOf(address(this))
    );

    trading = false;

    emit TradeCanceled();
  }

  /// @notice Transfer any tokens accidentally sent to this contract to Aave V2 Collector
    /// @param tokens List of token addresses
    function rescueTokens(address[] calldata tokens) external {
        for (uint256 i = 0; i < tokens.length; ++i) {
            IERC20(tokens[i]).safeTransfer(address(AaveV2Ethereum.COLLECTOR), IERC20(tokens[i]).balanceOf(address(this)));
        }
    }
}
