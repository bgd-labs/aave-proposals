// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Ownable} from 'solidity-utils/contracts/oz-common/Ownable.sol';

abstract contract Core is Ownable {
  /// @notice Provided address is 0x address
  error Invalid0xAddress();
  /// @notice Not authorized
  error InvalidCaller();
  /// @notice Token not registered as valid in the system
  error TokenNotRegistered();

  modifier onlyOwnerOrManager() {
    if (msg.sender != owner() && msg.sender != manager) revert InvalidCaller();
    _;
  }

  /// @notice One week, in seconds. Vote-locking is rounded down to weeks.
  uint256 internal constant WEEK = 7 days;

  address public manager;
}
