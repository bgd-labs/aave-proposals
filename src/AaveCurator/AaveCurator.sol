// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {VersionedInitializable} from './libs/VersionedInitializable.sol';
import {IWeth} from './interfaces/IWeth.sol';
import {IWstEth} from './interfaces/IWstEth.sol';
import {ILido} from './interfaces/ILido.sol';
import {IMilkman} from './interfaces/IMilkman.sol';
import {IRocketPoolDeposit} from './interfaces/IRocketPoolDeposit.sol';

contract AaveCurator is VersionedInitializable {
  using SafeERC20 for IERC20;

  event AdminChanged(address indexed oldAdmin, address indexed newAdmin);
  event ManagerChanged(address indexed oldAdmin, address indexed newAdmin);
  event SwapCanceled(address fromToken, address toToken, uint256 amount);
  event SwapRequested(address fromToken, address toToken, uint256 amount);
  event TokenUpdated(address indexed token, bool allowed);

  error Invalid0xAddress();
  error InvalidAmount();
  error InvalidCaller();
  error InvalidOracleType();
  error InvalidRecipient();
  error InvalidToken();
  error OracleNotSet();

  enum TokenType {
    Standard,
    BPT8020
  }

  modifier onlyAdmin() {
    if (msg.sender != admin) revert InvalidCaller();
    _;
  }

  modifier onlyAdminOrManager() {
    if (msg.sender != admin && msg.sender != manager) {
      revert InvalidCaller();
    }
    _;
  }

  IRocketPoolDeposit private constant ROCKET_POOL =
    IRocketPoolDeposit(0xDD3f50F8A6CafbE9b31a427582963f465E745AF8);
  IWeth private constant WETH = IWeth(AaveV2EthereumAssets.WETH_UNDERLYING);

  address public constant STETH = AaveV2EthereumAssets.stETH_UNDERLYING;
  address public constant BPT_PRICE_CHECKER = 0x7961bBC81352F26d073aA795EED51290C350D404; // TODO: Update with new one
  address public constant CHAINLINK_PRICE_CHECKER = 0x4D2c3773E69cB69963bFd376e538eC754409ACFa;

  address public admin = AaveGovernanceV2.SHORT_EXECUTOR;
  address public milkman = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public manager;

  mapping(address => bool) public allowedFromTokens;
  mapping(address => bool) public allowedToTokens;
  mapping(address => address) public tokenChainlinkOracle;

  /// @notice Current revision of the contract.
  uint256 public constant REVISION = 1;

  function initialize() external initializer {
    admin = AaveGovernanceV2.SHORT_EXECUTOR;
    emit AdminChanged(address(0), admin);
  }

  function swap(
    address fromToken,
    address toToken,
    address recipient,
    uint256 amount,
    uint256 slippage,
    TokenType _tokenType
  ) external onlyAdminOrManager {
    if (amount == 0) revert InvalidAmount();
    if (!allowedFromTokens[fromToken]) revert InvalidToken();
    if (!allowedToTokens[toToken]) revert InvalidToken();
    if (recipient != address(this) && recipient != address(AaveV3Ethereum.COLLECTOR)) {
      revert InvalidRecipient();
    }

    IERC20(fromToken).approve(milkman, amount);

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
  ) external onlyAdminOrManager {
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

  /// @notice Withdraws wETH into ETH, then deposits for wstETH
  function depositWstETH(uint256 amount) external onlyAdmin {
    WETH.withdraw(amount);
    ILido(STETH).submit{value: amount}(address(0));
    IERC20(STETH).approve(AaveV3EthereumAssets.wstETH_UNDERLYING, amount);
    IWstEth(AaveV3EthereumAssets.wstETH_UNDERLYING).wrap(amount);

    IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(address(this))
    );
  }

  /// @notice Withdraws wETH into ETH, then deposits for rETH
  function depositRETH(uint256 amount) external onlyAdmin {
    WETH.withdraw(amount);
    ROCKET_POOL.deposit{value: amount}();

    IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(this))
    );
  }

  function depositTokenIntoV2(address token) external onlyAdminOrManager {
    if (!allowedToTokens[token]) revert InvalidToken();
    AaveV2Ethereum.POOL.deposit(
      token,
      IERC20(token).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }

  function depositTokenIntoV3(address token) external onlyAdminOrManager {
    if (!allowedToTokens[token]) revert InvalidToken();
    AaveV3Ethereum.POOL.deposit(
      token,
      IERC20(token).balanceOf(address(this)),
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }

  function setAdmin(address _admin) external onlyAdmin {
    address oldAdmin = admin;
    admin = _admin;
    emit AdminChanged(oldAdmin, admin);
  }

  function setManager(address _manager) external onlyAdmin {
    if (_manager == address(0)) revert Invalid0xAddress();
    address oldManager = manager;
    manager = _manager;
    emit ManagerChanged(oldManager, manager);
  }

  function removeManager() external onlyAdmin {
    address oldManager = manager;
    manager = address(0);
    emit ManagerChanged(oldManager, manager);
  }

  function setAllowedFromToken(address token, address oracle, bool allowed) external onlyAdmin {
    if (token == address(0)) revert Invalid0xAddress();
    if (oracle == address(0)) revert Invalid0xAddress();
    allowedFromTokens[token] = allowed;
    tokenChainlinkOracle[token] = oracle;
    emit TokenUpdated(token, allowed);
  }

  function setAllowedToToken(address token, address oracle, bool allowed) external onlyAdmin {
    if (token == address(0)) revert Invalid0xAddress();
    if (oracle == address(0)) revert Invalid0xAddress();
    allowedToTokens[token] = allowed;
    tokenChainlinkOracle[token] = oracle;
    emit TokenUpdated(token, allowed);
  }

  function setMilkmanAddress(address _milkman) external onlyAdmin {
    if (_milkman == address(0)) revert Invalid0xAddress();
    milkman = _milkman;
  }

  /// @notice Transfer any tokens on this contract to Aave V3 Collector
  /// @param tokens List of token addresses
  function withdrawToCollector(address[] calldata tokens) external onlyAdminOrManager {
    for (uint256 i = 0; i < tokens.length; ++i) {
      IERC20(tokens[i]).safeTransfer(
        address(AaveV3Ethereum.COLLECTOR),
        IERC20(tokens[i]).balanceOf(address(this))
      );
    }
  }

  receive() external payable {}

  /// @inheritdoc VersionedInitializable
  function getRevision() internal pure override returns (uint256) {
    return REVISION;
  }

  function _getPriceCheckerAndData(
    TokenType _tokenType,
    uint256 slippage,
    address fromToken,
    address toToken
  ) internal returns (address, bytes memory) {
    if (_tokenType == TokenType.Standard) {
      return (CHAINLINK_PRICE_CHECKER, _getChainlinkCheckerData(slippage, fromToken, toToken));
    } else if (_tokenType == TokenType.BPT8020) {
      return (BPT_PRICE_CHECKER, _getBPTCheckerData(slippage, fromToken, toToken));
    } else {
      revert InvalidOracleType();
    }
  }

  function _getChainlinkCheckerData(
    uint256 slippage,
    address fromToken,
    address toToken
  ) internal view returns (bytes memory) {
    address oracleOne = tokenChainlinkOracle[fromToken];
    address oracleTwo = tokenChainlinkOracle[toToken];

    if (oracleOne == address(0) || oracleTwo == address(0)) revert OracleNotSet();

    address[] memory paths = new address[](2);
    paths[0] = oracleOne;
    paths[1] = oracleTwo;

    bool[] memory reverses = new bool[](2);

    bytes memory data = abi.encode(paths, reverses);
    return abi.encode(slippage, data);
  }

  function _getBPTCheckerData(
    uint256 slippage,
    address fromToken,
    address toToken
  ) internal view returns (bytes memory) {
    // TODO: Generic checker for 80/20 tokens in development
  }
}
