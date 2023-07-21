// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {OwnableWithGuardian} from 'solidity-utils/contracts/access-control/OwnableWithGuardian.sol';
import {Initializable} from 'solidity-utils/contracts/transparent-proxy/Initializable.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {IMilkman} from './interfaces/IMilkman.sol';

contract AaveCurator is Initializable, OwnableWithGuardian {
  using SafeERC20 for IERC20;

  event DepositedIntoV2(address indexed token, uint256 amount);
  event DepositedIntoV3(address indexed token, uint256 amount);
  event SwapCanceled(address fromToken, address toToken, uint256 amount);
  event SwapRequested(address fromToken, address toToken, uint256 amount);
  event TokenUpdated(address indexed token, bool allowed);

  error Invalid0xAddress();
  error InvalidAmount();
  error InvalidOracleType();
  error InvalidRecipient();
  error InvalidToken();
  error OracleNotSet();

  enum TokenType {
    Standard,
    BPT8020
  }

  address public constant BPT_PRICE_CHECKER = 0x7961bBC81352F26d073aA795EED51290C350D404; // TODO: Update with new one
  address public constant CHAINLINK_PRICE_CHECKER = 0x4D2c3773E69cB69963bFd376e538eC754409ACFa;

  address public milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;

  mapping(address tokenAddress => bool) public allowedFromTokens;
  mapping(address tokenAddress => bool) public allowedToTokens;
  /// @notice Chainlink Oracle address for given token (supports only USD bases)
  mapping(address tokenAddress => address) public tokenChainlinkOracle;

  function initialize() external initializer {
    _transferOwnership(_msgSender());
    _updateGuardian(_msgSender());
  }

  function swap(
    address fromToken,
    address toToken,
    address recipient,
    uint256 amount,
    uint256 slippage,
    TokenType _tokenType
  ) external onlyOwnerOrGuardian {
    if (amount == 0) revert InvalidAmount();
    if (!allowedFromTokens[fromToken]) revert InvalidToken();
    if (!allowedToTokens[toToken]) revert InvalidToken();
    if (recipient != address(this) && recipient != address(AaveV3Ethereum.COLLECTOR)) {
      revert InvalidRecipient();
    }

    IERC20(fromToken).safeApprove(milkman, amount);

    (address priceChecker, bytes memory data) = _getPriceCheckerAndData(
      _tokenType,
      slippage,
      fromToken,
      toToken
    );

    IMilkman(milkman).requestSwapExactTokensForTokens(
      amount,
      IERC20(fromToken),
      IERC20(toToken),
      recipient,
      priceChecker,
      data
    );

    emit SwapRequested(fromToken, toToken, amount);
  }

  function cancelSwap(
    address tradeMilkman,
    address fromToken,
    address toToken,
    address recipient,
    uint256 amount,
    uint256 slippage,
    TokenType _tokenType
  ) external onlyOwnerOrGuardian {
    (address priceChecker, bytes memory data) = _getPriceCheckerAndData(
      _tokenType,
      slippage,
      fromToken,
      toToken
    );

    IMilkman(tradeMilkman).cancelSwap(
      amount,
      IERC20(fromToken),
      IERC20(toToken),
      recipient,
      priceChecker,
      data
    );

    IERC20(fromToken).safeTransfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(fromToken).balanceOf(address(this))
    );

    emit SwapCanceled(fromToken, toToken, amount);
  }

  function depositTokenIntoV2(address token, uint256 amount) external onlyOwnerOrGuardian {
    if (!allowedFromTokens[token]) revert InvalidToken();
    IERC20(token).approve(address(AaveV2Ethereum.POOL), amount);
    AaveV2Ethereum.POOL.deposit(token, amount, address(AaveV3Ethereum.COLLECTOR), 0);
    emit DepositedIntoV2(token, amount);
  }

  function depositTokenIntoV3(address token, uint256 amount) external onlyOwnerOrGuardian {
    if (!allowedFromTokens[token]) revert InvalidToken();
    IERC20(token).approve(address(AaveV3Ethereum.POOL), amount);
    AaveV3Ethereum.POOL.deposit(token, amount, address(AaveV3Ethereum.COLLECTOR), 0);
    emit DepositedIntoV3(token, amount);
  }

  function setAllowedFromToken(address token, address oracle, bool allowed) external onlyOwner {
    if (token == address(0)) revert Invalid0xAddress();
    if (oracle == address(0)) revert Invalid0xAddress();
    allowedFromTokens[token] = allowed;
    tokenChainlinkOracle[token] = oracle;
    emit TokenUpdated(token, allowed);
  }

  function setAllowedToToken(address token, address oracle, bool allowed) external onlyOwner {
    if (token == address(0)) revert Invalid0xAddress();
    if (oracle == address(0)) revert Invalid0xAddress();
    allowedToTokens[token] = allowed;
    tokenChainlinkOracle[token] = oracle;
    emit TokenUpdated(token, allowed);
  }

  function setMilkmanAddress(address _milkman) external onlyOwner {
    if (_milkman == address(0)) revert Invalid0xAddress();
    milkman = _milkman;
  }

  /// @notice Transfer any tokens on this contract to Aave V3 Collector
  /// @param tokens List of token addresses
  function withdrawToCollector(address[] calldata tokens) external onlyOwnerOrGuardian {
    for (uint256 i = 0; i < tokens.length; ++i) {
      IERC20(tokens[i]).safeTransfer(
        address(AaveV3Ethereum.COLLECTOR),
        IERC20(tokens[i]).balanceOf(address(this))
      );
    }
  }

  receive() external payable {}

  function _getPriceCheckerAndData(
    TokenType _tokenType,
    uint256 slippage,
    address fromToken,
    address toToken
  ) internal view returns (address, bytes memory) {
    if (_tokenType == TokenType.Standard) {
      return (
        CHAINLINK_PRICE_CHECKER,
        abi.encode(slippage, _getChainlinkCheckerData(fromToken, toToken))
      );
    } else if (_tokenType == TokenType.BPT8020) {
      return (BPT_PRICE_CHECKER, abi.encode(slippage, _getBPTCheckerData(fromToken, toToken)));
    } else {
      revert InvalidOracleType();
    }
  }

  function _getChainlinkCheckerData(
    address fromToken,
    address toToken
  ) internal view returns (bytes memory) {
    address oracleOne = tokenChainlinkOracle[fromToken];
    address oracleTwo = tokenChainlinkOracle[toToken];

    if (oracleOne == address(0) || oracleTwo == address(0)) revert OracleNotSet();

    address[] memory paths = new address[](3);
    paths[0] = oracleOne;
    paths[1] = oracleTwo;

    bool[] memory reverses = new bool[](2);
    reverses[1] = true;

    return abi.encode(paths, reverses);
  }

  function _getBPTCheckerData(
    address fromToken,
    address toToken
  ) internal view returns (bytes memory) {
    // TODO: Generic checker for 80/20 tokens in development
  }
}
