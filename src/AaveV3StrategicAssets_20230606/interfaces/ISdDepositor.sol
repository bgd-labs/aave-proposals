// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ISdDepositor {
  /// @notice Deposit & Lock Token
  /// @dev User needs to approve the contract to transfer the token
  /// @param _amount The amount of token to deposit
  /// @param _lock Whether to lock the token
  /// @param _stake Whether to stake the token
  /// @param _user User to deposit for
  function deposit(uint256 _amount, bool _lock, bool _stake, address _user) external;

  function gauge() external returns (address);
}
