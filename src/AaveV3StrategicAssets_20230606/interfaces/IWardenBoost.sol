// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

interface IWardenBoost {
  struct BoostOffer {
    // Address of the user making the offer
    address user;
    // Price per vote per second, set by the user
    uint256 pricePerVote;
    // Max duration a Boost from this offer can last
    uint64 maxDuration;
    // Timestamp of expiry of the Offer
    uint64 expiryTime;
    // Minimum percent of users voting token balance to buy for a Boost
    uint16 minPerc; //bps
    // Maximum percent of users total voting token balance available to delegate
    uint16 maxPerc; //bps
    // Use the advised price instead of the Offer one
    bool useAdvicePrice;
  }

  function claim() external returns (bool);

  function claimBoostReward(uint256 boostId) external returns (bool);

  function delegationBoost() external returns (address);

  function feeToken() external returns (IERC20);

  function nextBoostId() external returns (uint256);

  function offers(uint256 boostId) external returns (BoostOffer memory);

  /**
   * @notice Registers a new user wanting to sell its delegation
   * @dev Regsiters a new user, creates a BoostOffer with the given parameters
   * @param pricePerVote Price of 1 vote per second (in wei)
   * @param maxDuration Maximum duration (in weeks) that a Boost can last when taken from this Offer
   * @param expiryTime Timestamp when this Offer is not longer valid
   * @param minPerc Minimum percent of users voting token balance to buy for a Boost (in BPS)
   * @param maxPerc Maximum percent of users total voting token balance available to delegate (in BPS)
   * @param useAdvicePrice True to use the advice Price instead of the given pricePerVote
   */
  function register(
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external returns (bool);

  function updateOffer(
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external returns (bool);

  function quit() external returns (bool);

  function estimateFees(
    address delegator,
    uint256 amount,
    uint256 duration //in weeks
  ) external view returns (uint256);

  function buyDelegationBoost(
    address delegator,
    address receiver,
    uint256 amount,
    uint256 duration, //in weeks
    uint256 maxFeeAmount
  ) external returns (uint256);
}
