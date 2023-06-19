// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {IWeth} from './interfaces/IWeth.sol';
import {IMilkman} from './interfaces/IMilkman.sol';
import {IRocketPoolDeposit} from './interfaces/IRocketPoolDeposit.sol';

contract AaveCurator {
    using SafeERC20 for IERC20;

    error Invalid0xAddress();
    error InvalidCaller();
    error InvalidRecipient();
    error InvalidToken();
    event TradeCanceled(address fromToken, address toToken, uint256 amount);
    event TradeRequested(address fromToken, address toToken, uint256 amount);

    IRocketPoolDeposit private constant ROCKET_POOL = IRocketPoolDeposit(0xDD3f50F8A6CafbE9b31a427582963f465E745AF8);
    IWeth private constant WETH = IWeth(AaveV2Ethereum.WETH_UNDERLYING);

    address public constant admin = AaveGovernanceV2.SHORT_EXECUTOR;
    address public constant WSTETH = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;
    address public milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
    address public manager;

    mapping (address => IERC20) private allowedFromTokens;
    mapping (address => IERC20) private allowedToTokens;
    mapping (address => address) private tokenChainlinkOracle;

    // TODO: Should we have array of allowed tokens for easy access to the list?
    // Same for allowed callers and price checkers.

    // address public constant PRICE_CHECKER = 0x7961bBC81352F26d073aA795EED51290C350D404;
    // address public constant CHAINLINK_PRICE_CHECKER = 0x4d2c3773e69cb69963bfd376e538ec754409acfa;

    modifier onlyAdmin() {
        if (msg.sender != admin) revert InvalidCaller();
    }

    modifier onlyAdminOrAllowedCaller() {
        if (msg.sender != admin && msg.sender != manager) {
            revert InvalidCaller();
        }
    }

    function trade(address fromToken, address toToken, address recipient, bytes32 checkerType) external onlyAdminOrAllowedCaller {
        if (!allowedFromTokens[fromToken]) revert InvalidToken();
        if (!allowedToTokens[toToken]) revert InvalidToken();
        if (recipient != address(this) || recipient != address(AaveV3Ethereum.COLLECTOR)) {
            revert InvalidRecipient();
        }

        uint256 balance = IERC20(fromToken).balanceOf(address(this));

        if (balance == 0) return; // TODO: Revert?

        IERC20(fromToken).approve(milkman, balance);

        IMilkman(milkman).requestSwapExactTokensForTokens(
            balance,
            fromToken,
            toToken,
            recipient
            PRICE_CHECKER, // TODO: How to do generically the price checker?
            abi.encode(150) // TODO: How to do generically the slippage?
        );

        emit TradeRequested(fromToken, toToken, balance);
    }

    // TODO: Bulk trade? Bulk claimFees? Bulk cancel?

    /// @notice Withdraws wETH into ETH, then deposits for wstETH
    function depositWstETH(uint256 amount) external onlyAdmin {
        WETH.withdraw(amount);
        WSTETH.call{value: amount}();
    }

    /// @notice Withdraws wETH into ETH, then deposits for rETH
    function depositRETH(uint256 amount) external onlyAdmin {
        WETH.withdraw(amount);
        ROCKET_POOL.deposit{value: amount}();
    }

    function cancelTrade(address tradeMilkman, address fromToken, address toToken, address recipient, uint256 amount) external onlyAdminOrAllowedCaller {
        IMilkman(tradeMilkman).cancelSwap(
            amount,
            fromToken,
            toToken,
            recipient,
            PRICE_CHECKER, // TODO
            abi.encode(150) // TODO
        );

        IERC20(fromToken).safeTransfer(
            address(AaveV3Ethereum.COLLECTOR),
            IERC20(fromToken).balanceOf(address(this))
        );

        emit TradeCanceled(fromToken, toToken, amount);
    }

    function depositTokenIntoV2(address token) external onlyAdminOrAllowedCaller {
        if (!allowedToTokens[token]) revert InvalidToken();
        AaveV2Ethereum.POOL.deposit(token, IERC20(token).balanceOf(address(this)), address(AaveV3Ethereum.COLLECTOR), 0);
    }

    function depositTokenIntoV3(address token) external onlyAdminOrAllowedCaller {
        if (!allowedToTokens[token]) revert InvalidToken();
        AaveV3Ethereum.POOL.deposit(token, IERC20(token).balanceOf(address(this)), address(AaveV3Ethereum.COLLECTOR), 0);
    }

    function setManager(address _manager) external onlyAdmin {
        if (_manager == address(0)) revert Invalid0xAddress();
        manager = _manager;
    }

    function removeManager() external onlyAdmin {
        manager = address(0);
    }

    function setAllowedFromToken(address token, address oracle, bool allowed) external onlyAdminOrAllowedCaller {
        if (token == address(0)) revert Invalid0xAddress();
        if (oracle == address(0)) revert Invalid0xAddress();
        allowedFromTokens[token] = allowed;
        tokenChainlinkOracle[token] = oracle;
    }

    function setAllowedToToken(address token, address oracle, bool allowed) external onlyAdminOrAllowedCaller {
        if (token == address(0)) revert Invalid0xAddress();
        if (oracle == address(0)) revert Invalid0xAddress();
        allowedToTokens[token] = allowed;
        tokenChainlinkOracle[token] = oracle;
    }

    function setMilkmanAddress(address _milkman) external onlyAdmin {
        if (_milkman == address(0)) revert Invalid0xAddress();
        milkman = _milkman;
    }

    /// @notice Transfer any tokens accidentally sent to this contract to Aave V3 Collector
    /// @param tokens List of token addresses
    function rescueTokens(address[] calldata tokens) external onlyAdminOrAllowedCaller {
        for (uint256 i = 0; i < tokens.length; ++i) {
            IERC20(tokens[i]).safeTransfer(address(AaveV3Ethereum.COLLECTOR), IERC20(tokens[i]).balanceOf(address(this)));
        }
    }
}
