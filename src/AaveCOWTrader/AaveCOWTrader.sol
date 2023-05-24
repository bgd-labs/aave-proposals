// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {ReentrancyGuard} from "openzeppelin...";
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

contract AaveCOWTrader {
    using SafeERC20 for IERC20;

    error Invalid0xAddress();
    error InvalidCaller();
    error InvalidToken();
    event TradeCanceled(address fromToken, address toToken, uint256 amount);
    event TradeRequested(address fromToken, address toToken, uint256 amount);

    address public milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address public admin = AaveGovernanceV2.SHORT_EXECUTOR;

    mapping (address => bool) private allowedCallers;
    mapping (address => IERC20) private allowedFromTokens;
    mapping (address => IERC20) private allowedToTokens;

    constructor() {
        // TODO: Set allowed tokens here?
    }

    modifier onlyAdmin() {
        if (msg.sender != admin) revert InvalidCaller();
    }

    modifier onlyAdminOrAllowedCaller() {
        if (msg.sender != admin || allowedCallers[msg.sender]) {
            revert InvalidCaller();
        }
    }

    function trade(address fromToken, address toToken) external onlyAdminOrAllowedCaller {
        if (!allowedFromTokens[fromToken]) revert InvalidToken();
        if (!allowedToTokens[toToken]) revert InvalidToken();

        uint256 balance = IERC20(fromToken).balanceOf(address(this));

        if (balance == 0) return;

        IERC20(fromToken).approve(milkman, balance);

        IMilkman(milkman).requestSwapExactTokensForTokens(
            balance,
            fromToken,
            toToken,
            address(AaveV3Ethereum.COLLECTOR),
            PRICE_CHECKER, // TODO: How to do generically the price checker?
            abi.encode(150) // TODO: How to do generically the slippage?
        );

        emit TradeRequested(fromToken, toToken, balance);
    }

    function cancelTrade(address tradeMilkman, address fromToken, address toToken, uint256 amount) external onlyAdminOrAllowedCaller {
        IMilkman(tradeMilkman).cancelSwap(
            amount,
            fromToken,
            toToken,
            address(AaveV3Ethereum.COLLECTOR),
            PRICE_CHECKER, // TODO
            abi.encode(150) // TODO
        );

        IERC20(fromToken).safeTransfer(
            address(AaveV3Ethereum.COLLECTOR),
            IERC20(fromToken).balanceOf(address(this))
        );

        emit TradeCanceled(fromToken, toToken, amount);
    }

    function depositTokenIntoAave(address token) external onlyAdminOrAllowedCaller {
        if (!allowedToTokens[token]) revert InvalidToken();
        AaveV3Ethereum.POOL.deposit(token, IERC20(token).balanceOf(address(this)), address(AaveV3Ethereum.COLLECTOR), 0);
    }

    function setAllowedCaller(address caller, bool allowed) external onlyAdmin {
        if (caller == address(0)) revert Invalid0xAddress();
        allowedCallers[caller] = allowed;
    }

    function setAllowedFromToken(address token, bool allowed) external onlyAdminOrAllowedCaller {
        if (token == address(0)) revert Invalid0xAddress();
        allowedFromTokens[token] = allowed;
    }

    function setAllowedToToken(address token, bool allowed) external onlyAdminOrAllowedCaller {
        if (token == address(0)) revert Invalid0xAddress();
        allowedToTokens[token] = allowed;
    }

    function setMilkmanAddress(address _milkman) external onlyAdmin {
        if (_milkman == address(0)) revert Invalid0xAddress();
        milkman = _milkman;
    }

    /// @notice Transfer any tokens accidentally sent to this contract to Aave V3 Collector
    /// @param tokens List of token addresses
    function rescueTokens(address[] calldata tokens) external {
        for (uint256 i = 0; i < tokens.length; ++i) {
            IERC20(tokens[i]).safeTransfer(address(AaveV3Ethereum.COLLECTOR), IERC20(tokens[i]).balanceOf(address(this)));
        }
    }
}

//   address public constant PRICE_CHECKER = 0x7961bBC81352F26d073aA795EED51290C350D404;