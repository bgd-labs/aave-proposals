// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';

import {VersionedInitializable} from './libs/VersionedInitializable.sol';
import {SdTokenManager} from './SdTokenManager.sol';
import {LSDLiquidityGaugeManager} from './LSDLiquidityGaugeManager.sol';
import {VeTokenManager} from './VeTokenManager.sol';

contract StrategicAssetsManager is
  VersionedInitializable,
  LSDLiquidityGaugeManager,
  VeTokenManager,
  SdTokenManager
{
  using SafeERC20 for IERC20;

  event AdminChanged(address indexed oldAdmin, address indexed newAdmin);
  event SdTokenAdded(address indexed underlying, address sdToken);
  event SdTokenRemoved(address indexed underlying, address sdToken);
  event StrategicAssetsManagerChanged(address indexed oldManager, address indexed newManager);
  event VeTokenAdded(address indexed underlying, address veToken);
  event VeTokenRemoved(address indexed underlying, address veToken);
  event WithdrawalERC20(address indexed _token, address _to, uint256 _amount);

  /// @notice Current revision of the contract.
  uint256 public constant REVISION = 1;

  function initialize() external initializer {
    admin = AaveGovernanceV2.SHORT_EXECUTOR;
    emit AdminChanged(address(0), admin);
  }

  function addVeToken(
    address underlying,
    address veToken,
    address warden,
    uint256 lockDuration,
    address initialDelegate,
    bytes32 spaceId
  ) external onlyAdmin {
    if (underlying == address(0) || veToken == address(0)) revert Invalid0xAddress();

    VeToken memory newToken;
    newToken.veToken = veToken;
    newToken.warden = warden;
    newToken.lockDuration = lockDuration;
    newToken.delegate = initialDelegate; // TODO: _setDelegateSnapshot(); internal
    newToken.spaceId = spaceId; // TODO: _setSpaceId(); internal

    veTokens[underlying] = newToken;

    if (initialDelegate != address(0)) {
      _delegate(veTokens[underlying], initialDelegate);
    }

    if (spaceId != '') {
      _setSpaceId(veTokens[underlying], spaceId);
    }

    emit VeTokenAdded(underlying, veToken);
  }

  function removeVeToken(address underlying) external onlyAdmin {
    address veToken = veTokens[underlying].veToken;
    delete veTokens[underlying];
    emit VeTokenRemoved(underlying, veToken);
  }

  function addSdToken(address underlying, address sdToken, address depositor) external onlyAdmin {
    if (underlying == address(0) || sdToken == address(0) || depositor == address(0))
      revert Invalid0xAddress();

    SdToken memory newToken;
    newToken.sdToken = sdToken;
    newToken.depositor = depositor;

    sdTokens[underlying] = newToken;
    emit SdTokenAdded(underlying, sdToken);
  }

  function removeSdToken(address underlying) external onlyAdmin {
    address sdToken = sdTokens[underlying].sdToken;
    delete sdTokens[underlying];
    emit SdTokenRemoved(underlying, sdToken);
  }

  function withdrawERC20(address token, address to, uint256 amount) external onlyAdmin {
    if (to == address(0)) revert Invalid0xAddress();

    IERC20(token).safeTransfer(to, amount);
    emit WithdrawalERC20(token, to, amount);
  }

  function setAdmin(address _admin) external onlyAdmin {
    address oldAdmin = admin;
    admin = _admin;
    emit AdminChanged(oldAdmin, admin);
  }

  function setStrategicAssetsManager(address _manager) external onlyAdmin {
    if (_manager == address(0)) revert Invalid0xAddress();
    address oldManager = manager;
    manager = _manager;
    emit StrategicAssetsManagerChanged(oldManager, manager);
  }

  function removeStrategicAssetManager() external onlyAdmin {
    address oldManager = manager;
    manager = address(0);
    emit StrategicAssetsManagerChanged(oldManager, manager);
  }

  /// @inheritdoc VersionedInitializable
  function getRevision() internal pure override returns (uint256) {
    return REVISION;
  }
}
