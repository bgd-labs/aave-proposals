// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {DelegateRegistry} from './interfaces/IDelegateRegistry.sol';
import {IVeToken} from './interfaces/IVeToken.sol';
import {IWardenBoost} from './interfaces/IWardenBoost.sol';
import {IAragonVoting} from './interfaces/IAragonVoting.sol';
import {Core} from './Core.sol';

abstract contract VeTokenManager is Core {
  using SafeERC20 for IERC20;

  event BuyBoost(address delegator, address receiver, uint256 amount, uint256 duration);
  event DelegateUpdate(address indexed oldDelegate, address indexed newDelegate);
  event Lock(uint256 cummulativeTokensLocked, uint256 lockHorizon);
  event Unlock(uint256 tokensUnlocked);
  event VoteCast(uint256 voteData, bool support);
  event VotingContractUpdate(address indexed token, address voting);

  /// @notice The new lock duration must be greater than the current one
  error InvalidNewDuration();
  /// @notice The on-chain voting contract has not been set for this token
  error VotingContractNotRegistered();

  struct VeToken {
    /// @notice the keccak encoded spaceId of the snapshot space
    bytes32 spaceId;
    /// @notice The lock duration of veToken
    uint256 lockDuration;
    /// @notice Address of veToken
    address veToken;
    /// @notice the snapshot delegate for the deposit
    address delegate;
    /// @notice Warden contract address for veBoost
    address warden;
  }

  DelegateRegistry public constant DELEGATE_REGISTRY =
    DelegateRegistry(0x469788fE6E9E9681C6ebF3bF78e7Fd26Fc015446);

  mapping(address => VeToken) public veTokens;
  mapping(address => address) public veTokenToVotingContract;

  /// @notice The Buyer will then need to call the user_checkpoint() method on all Curve V4 & Factory Gauges
  /// currently farming, to apply the newly received Boost.
  /// @notice duration in weeks (ie: 1 for 1 Week)
  function buyBoost(
    address underlying,
    address delegator,
    address receiver,
    uint256 amount,
    uint256 duration
  ) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.warden == address(0)) revert TokenNotRegistered();

    IERC20 feeToken = IWardenBoost(token.warden).feeToken();
    uint256 maxFee = IWardenBoost(token.warden).estimateFees(delegator, amount, duration);
    feeToken.approve(token.warden, maxFee);
    IWardenBoost(token.warden).buyDelegationBoost(delegator, receiver, amount, duration, maxFee);

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
    address underlying,
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.warden == address(0)) revert TokenNotRegistered();

    IERC20(IWardenBoost(token.warden).delegationBoost()).safeApprove(
      token.warden,
      type(uint256).max // Per Boost docs, approve uint256 max
    );
    IWardenBoost(token.warden).register(
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
    address underlying,
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.warden == address(0)) revert TokenNotRegistered();

    IWardenBoost(token.warden).updateOffer(
      pricePerVote,
      maxDuration,
      expiryTime,
      minPerc,
      maxPerc,
      useAdvicePrice
    );
  }

  /// @notice Removes an existing boost offer
  function removeBoostOffer(address underlying) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.warden == address(0)) revert TokenNotRegistered();

    IERC20(IWardenBoost(token.warden).delegationBoost()).safeApprove(token.warden, 0);
    IWardenBoost(token.warden).quit();
  }

  /// @notice Claim fee token rewards accrued by selling veBoost
  function claim(address underlying) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.warden == address(0)) revert TokenNotRegistered();

    IWardenBoost(token.warden).claim();
  }

  /// @notice sets the snapshot space ID
  /// @notice delegate must previously have been set or reverts
  function setSpaceId(address underlying, bytes32 _spaceId) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();

    _setSpaceId(token, _spaceId);
  }

  /// @notice sets the snapshot delegate
  function setDelegateSnapshot(
    address underlying,
    address newDelegate
  ) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();

    _delegate(token, newDelegate);
  }

  /// @notice clears the delegate from snapshot
  function clearDelegateSnapshot(address underlying) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();

    address oldDelegate = token.delegate;
    DELEGATE_REGISTRY.clearDelegate(token.spaceId);

    emit DelegateUpdate(oldDelegate, address(0));
  }

  function voteAragon(
    address underlying,
    uint256 voteData,
    bool support
  ) external onlyOwnerOrGuardian {
    address voting = veTokenToVotingContract[underlying];
    if (voting == address(0)) revert VotingContractNotRegistered();
    // TODO: Finish Curve.fi Voting Parameter: 0xBCfF8B0b9419b9A88c44546519b1e909cF330399
    // TODO: Delegate?
    IAragonVoting(voting).vote(voteData, support, false);
    emit VoteCast(voteData, support);
  }

  function setVotingContract(address underlying, address voting) external onlyOwnerOrGuardian {
    if (veTokens[underlying].veToken == address(0)) revert TokenNotRegistered();
    if (voting == address(0)) revert Invalid0xAddress();

    veTokenToVotingContract[underlying] = voting;
    emit VotingContractUpdate(underlying, voting);
  }

  /// @notice Increases the lock duration for underlying token
  function setLockDuration(
    address underlying,
    uint256 newLockDuration
  ) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();
    if (newLockDuration < token.lockDuration) revert InvalidNewDuration();

    token.lockDuration = newLockDuration;
  }

  /// @notice Locks underlying token into veToken until lockDuration
  /// @notice Increases amount or lock duration if lock already exists
  function lock(address underlying) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();

    uint256 tokenBalance = IERC20(underlying).balanceOf(address(this));
    uint256 locked = IVeToken(token.veToken).locked(address(this));
    uint256 lockHorizon = ((block.timestamp + token.lockDuration) / WEEK) * WEEK;

    if (tokenBalance != 0 && locked == 0) {
      // First lock
      IERC20(underlying).approve(token.veToken, tokenBalance);
      IVeToken(token.veToken).create_lock(tokenBalance, lockHorizon);
    } else if (tokenBalance != 0 && locked != 0) {
      // Increase amount of tokens locked & refresh duration to lockDuration
      IERC20(underlying).approve(token.veToken, tokenBalance);
      IVeToken(token.veToken).increase_amount(tokenBalance);
      if (IVeToken(token.veToken).locked__end(address(this)) != lockHorizon) {
        IVeToken(token.veToken).increase_unlock_time(lockHorizon);
      }
    } else if (tokenBalance == 0 && locked != 0) {
      // No additional tokens to lock, just refresh duration to lockDuration
      IVeToken(token.veToken).increase_unlock_time(lockHorizon);
    } else {
      // If tokenBalance == 0 and locked == 0, there is nothing to do.
      return;
    }

    emit Lock(tokenBalance + locked, lockHorizon);
  }

  /// @notice Reverts if lockDuration has not passed
  function unlock(address underlying) external onlyOwnerOrGuardian {
    VeToken storage token = veTokens[underlying];
    if (token.veToken == address(0)) revert TokenNotRegistered();

    IVeToken(token.veToken).withdraw();
    emit Unlock(IERC20(underlying).balanceOf(address(this)));
  }

  function _delegate(VeToken storage token, address newDelegate) internal {
    address oldDelegate = token.delegate;
    DELEGATE_REGISTRY.setDelegate(token.spaceId, newDelegate);
    token.delegate = newDelegate;

    emit DelegateUpdate(oldDelegate, newDelegate);
  }

  function _setSpaceId(VeToken storage token, bytes32 _spaceId) internal {
    DELEGATE_REGISTRY.clearDelegate(token.spaceId);
    token.spaceId = _spaceId;
    _delegate(token, token.delegate);
  }
}
