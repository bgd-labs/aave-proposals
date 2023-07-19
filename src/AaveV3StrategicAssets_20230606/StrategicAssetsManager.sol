// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {Ownable} from 'solidity-utils/contracts/oz-common/Ownable.sol';
import {Initializable} from 'solidity-utils/contracts/transparent-proxy/Initializable.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {SdTokenManager} from './SdTokenManager.sol';
import {LSDLiquidityGaugeManager} from './LSDLiquidityGaugeManager.sol';
import {VeTokenManager} from './VeTokenManager.sol';

contract StrategicAssetsManager is
  Initializable,
  LSDLiquidityGaugeManager,
  VeTokenManager,
  SdTokenManager
{
  using SafeERC20 for IERC20;

  event SdTokenAdded(address indexed underlying, address sdToken);
  event SdTokenRemoved(address indexed underlying, address sdToken);
  event StrategicAssetsManagerChanged(address indexed oldManager, address indexed newManager);
  event VeTokenAdded(address indexed underlying, address veToken);
  event VeTokenRemoved(address indexed underlying, address veToken);
  event WithdrawalERC20(address indexed _token, address _to, uint256 _amount);

  function initialize() external initializer {
    _transferOwnership(_msgSender());
  }

  function addVeToken(
    address underlying,
    address veToken,
    address warden,
    uint256 lockDuration,
    address initialDelegate,
    bytes32 spaceId
  ) external onlyOwner {
    if (underlying == address(0) || veToken == address(0)) revert Invalid0xAddress();

    VeToken memory newToken;
    newToken.veToken = veToken;
    newToken.warden = warden;
    newToken.lockDuration = lockDuration;
    newToken.delegate = initialDelegate;
    newToken.spaceId = spaceId;

    veTokens[underlying] = newToken;

    if (initialDelegate != address(0)) {
      _delegate(veTokens[underlying], initialDelegate);
    }

    if (spaceId != '') {
      _setSpaceId(veTokens[underlying], spaceId);
    }

    emit VeTokenAdded(underlying, veToken);
  }

  function removeVeToken(address underlying) external onlyOwner {
    address veToken = veTokens[underlying].veToken;
    delete veTokens[underlying];
    emit VeTokenRemoved(underlying, veToken);
  }

  function addSdToken(address underlying, address sdToken, address depositor) external onlyOwner {
    if (underlying == address(0) || sdToken == address(0) || depositor == address(0))
      revert Invalid0xAddress();

    SdToken memory newToken;
    newToken.sdToken = sdToken;
    newToken.depositor = depositor;

    sdTokens[underlying] = newToken;
    emit SdTokenAdded(underlying, sdToken);
  }

  function removeSdToken(address underlying) external onlyOwner {
    address sdToken = sdTokens[underlying].sdToken;
    delete sdTokens[underlying];
    emit SdTokenRemoved(underlying, sdToken);
  }

  function withdrawERC20(address token, address to, uint256 amount) external onlyOwner {
    if (to == address(0)) revert Invalid0xAddress();

    IERC20(token).safeTransfer(to, amount);
    emit WithdrawalERC20(token, to, amount);
  }

  function setStrategicAssetsManager(address _manager) external onlyOwner {
    if (_manager == address(0)) revert Invalid0xAddress();
    address oldManager = manager;
    manager = _manager;
    emit StrategicAssetsManagerChanged(oldManager, manager);
  }

  function removeStrategicAssetManager() external onlyOwner {
    address oldManager = manager;
    manager = address(0);
    emit StrategicAssetsManagerChanged(oldManager, manager);
  }
}
