// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

library Errors {
    /// @notice Provided address is 0x address
  error Invalid0xAddress();
  /// @notice Token not registered as valid in the system
  error TokenNotRegistered();
}