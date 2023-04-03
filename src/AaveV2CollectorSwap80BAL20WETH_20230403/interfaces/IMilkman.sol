// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC20} from '@openzeppelin/token/ERC20/IERC20.sol';

/// @notice Asynchronously swap an exact amount of tokenIn for a market-determined amount of tokenOut.
/// @dev Swaps are usually completed in ~2 minutes.
/// @param amountIn The number of tokens to sell.
/// @param fromToken The token that the user wishes to sell.
/// @param toToken The token that the user wishes to receive.
/// @param to Who should receive the tokens.
/// @param priceChecker A contract that verifies an order (mainly its minOut and fee) before Milkman signs it.
/// @param priceCheckerData Data that gets passed to the price checker.
interface IMilkman {
  function requestSwapExactTokensForTokens(
    uint256 amountIn,
    IERC20 fromToken,
    IERC20 toToken,
    address to,
    address priceChecker,
    bytes calldata priceCheckerData
  ) external;
}
