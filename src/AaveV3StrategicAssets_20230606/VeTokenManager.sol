// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {DelegateRegistry} from './interfaces/IDelegateRegistry.sol';
import {IVeToken} from './interfaces/IVeToken.sol';
import {IWardenBoost} from './interfaces/IWardenBoost.sol';
import {Core} from './Core.sol';

abstract contract VeTokenManager is Core {
  event BuyBoost(address delegator, address receiver, uint256 amount, uint256 duration);
  event DelegateUpdate(address indexed oldDelegate, address indexed newDelegate);
  event Lock(uint256 cummulativeTokensLocked, uint256 lockHorizon);
  event Unlock(uint256 tokensUnlocked);

  DelegateRegistry public constant DELEGATE_REGISTRY =
    DelegateRegistry(0x469788fE6E9E9681C6ebF3bF78e7Fd26Fc015446);

  address public constant BAL = 0xba100000625a3754423978a60c9317c58a424e3D;
  address public constant B_80BAL_20WETH = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant VE_BAL = 0xC128a9954e6c874eA3d62ce62B468bA073093F25;
  address public constant WARDEN_VE_BAL = 0x42227bc7D65511a357c43993883c7cef53B25de9;

  /// @notice the snapshot delegate for the deposit
  address public delegate;
  /// @notice the keccak encoded spaceId of the snapshot space
  bytes32 public spaceId;
  /// @notice The lock duration of veToken
  uint256 lockDuration;

  /// @notice The Buyer will then need to call the user_checkpoint() method on all Curve V4 & Factory Gauges
  /// currently farming, to apply the newly received Boost.
  /// @notice duration in weeks (ie: 1 for 1 Week)
  function buyBoost(
    address delegator,
    address receiver,
    uint256 amount,
    uint256 duration
  ) external onlyOwnerOrGuardian {
    uint256 maxFee = IWardenBoost(WARDEN_VE_BAL).estimateFees(delegator, amount, duration);
    IERC20(BAL).approve(WARDEN_VE_BAL, maxFee);
    IWardenBoost(WARDEN_VE_BAL).buyDelegationBoost(delegator, receiver, amount, duration, maxFee);

    emit BuyBoost(delegator, receiver, amount, duration);
  }

  /// @notice Sells boost in order to accrue rewards
  /// @dev Registers a new user, creates a BoostOffer with the given parameters
  /// @param pricePerVote Price of 1 vote per second (in wei)
  /// @param maxDuration Maximum duration (in weeks) that a Boost can last when taken from this Offer
  /// @param expiryTime Timestamp when this Offer is not longer valid
  /// @param minPerc Minimum percent of users voting token balance to buy for a Boost (in BPS)
  /// @param maxPerc Maximum percent of users total voting token balance available to delegate (in BPS)
  /// @param useAdvicePrice True to use the advice Price instead of the given pricePerVote
  function sellBoost(
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrGuardian {
    IERC20(IWardenBoost(WARDEN_VE_BAL).delegationBoost()).approve(
      WARDEN_VE_BAL,
      type(uint256).max // Per Boost docs, approve uint256 max
    );
    IWardenBoost(WARDEN_VE_BAL).register(
      pricePerVote,
      maxDuration,
      expiryTime,
      minPerc,
      maxPerc,
      useAdvicePrice
    );
  }

  /// @notice Update an existing boost offer
  function updateBoostOffer(
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrGuardian {
    IWardenBoost(WARDEN_VE_BAL).updateOffer(
      pricePerVote,
      maxDuration,
      expiryTime,
      minPerc,
      maxPerc,
      useAdvicePrice
    );
  }

  /// @notice Removes an existing boost offer
  function removeBoostOffer() external onlyOwnerOrGuardian {
    IERC20(IWardenBoost(WARDEN_VE_BAL).delegationBoost()).approve(WARDEN_VE_BAL, 0);
    IWardenBoost(WARDEN_VE_BAL).quit();
  }

  /// @notice Claim fee token rewards accrued by selling veBoost
  function claim() external onlyOwnerOrGuardian {
    IWardenBoost(WARDEN_VE_BAL).claim();
  }

  /// @notice sets the snapshot space ID
  function setSpaceId(bytes32 _spaceId) external onlyOwnerOrGuardian {
    DELEGATE_REGISTRY.clearDelegate(spaceId);
    spaceId = _spaceId;
    _delegate(delegate);
  }

  /// @notice sets the snapshot delegate
  function setDelegate(address newDelegate) external onlyOwnerOrGuardian {
    _delegate(newDelegate);
  }

  /// @notice clears the delegate from snapshot
  function clearDelegate() external onlyOwnerOrGuardian {
    address oldDelegate = delegate;
    DELEGATE_REGISTRY.clearDelegate(spaceId);

    emit DelegateUpdate(oldDelegate, address(0));
  }

  /// @notice Increases the lock duration for underlying token
  function setLockDuration(uint256 newLockDuration) external onlyOwnerOrGuardian {
    lockDuration = newLockDuration;
  }

  /// @notice Locks underlying token into veToken until lockDuration
  /// @notice Increases amount or lock duration if lock already exists
  function lock() external onlyOwnerOrGuardian {
    uint256 tokenBalance = IERC20(B_80BAL_20WETH).balanceOf(address(this));
    uint256 locked = IVeToken(VE_BAL).locked(address(this));
    uint256 lockHorizon = ((block.timestamp + lockDuration) / WEEK) * WEEK;

    if (tokenBalance != 0 && locked == 0) {
      // First lock
      IERC20(B_80BAL_20WETH).approve(VE_BAL, tokenBalance);
      IVeToken(VE_BAL).create_lock(tokenBalance, lockHorizon);
    } else if (tokenBalance != 0 && locked != 0) {
      // Increase amount of tokens locked & refresh duration to lockDuration
      IERC20(B_80BAL_20WETH).approve(VE_BAL, tokenBalance);
      IVeToken(VE_BAL).increase_amount(tokenBalance);
      if (IVeToken(VE_BAL).locked__end(address(this)) != lockHorizon) {
        IVeToken(VE_BAL).increase_unlock_time(lockHorizon);
      }
    } else if (tokenBalance == 0 && locked != 0) {
      // No additional tokens to lock, just refresh duration to lockDuration
      IVeToken(VE_BAL).increase_unlock_time(lockHorizon);
    } else {
      // If tokenBalance == 0 and locked == 0, there is nothing to do.
      return;
    }

    emit Lock(tokenBalance + locked, lockHorizon);
  }

  /// @notice Reverts if lockDuration has not passed
  function unlock() external onlyOwnerOrGuardian {
    IVeToken(VE_BAL).withdraw();
    emit Unlock(IERC20(B_80BAL_20WETH).balanceOf(address(this)));
  }

  function _delegate(address newDelegate) internal {
    address oldDelegate = delegate;
    DELEGATE_REGISTRY.setDelegate(spaceId, newDelegate);
    delegate = newDelegate;

    emit DelegateUpdate(oldDelegate, newDelegate);
  }
}
