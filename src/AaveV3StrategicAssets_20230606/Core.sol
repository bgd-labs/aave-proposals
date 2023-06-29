// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

abstract contract Core {
  /// @notice Provided address is 0x address
  error Invalid0xAddress();
  /// @notice Not authorized
  error InvalidCaller();
  /// @notice Token not registered as valid in the system
  error TokenNotRegistered();

  modifier onlyAdmin() {
    if (msg.sender != admin) revert InvalidCaller();
    _;
  }

  modifier onlyAdminOrManager() {
    if (msg.sender != admin && msg.sender != manager) revert InvalidCaller();
    _;
  }

  /// @notice One week, in seconds. Vote-locking is rounded down to weeks.
  uint256 internal constant WEEK = 7 * 86400;

  address public admin;
  address public manager;
}
