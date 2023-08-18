// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {OwnableWithGuardian} from 'solidity-utils/contracts/access-control/OwnableWithGuardian.sol';

abstract contract Core is OwnableWithGuardian {
  /// @notice Provided address is 0x address
  error Invalid0xAddress();

  /// @notice One week, in seconds. Vote-locking is rounded down to weeks.
  uint256 internal constant WEEK = 7 days;
}
