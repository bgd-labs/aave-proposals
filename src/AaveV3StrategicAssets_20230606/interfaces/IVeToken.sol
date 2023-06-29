
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IVeToken {
  function balanceOf(address) external view returns (uint256);

  function locked(address) external view returns (uint256);

  function create_lock(uint256 value, uint256 unlock_time) external;

  function increase_amount(uint256 value) external;

  function increase_unlock_time(uint256 unlock_time) external;

  function withdraw() external;

  function locked__end(address) external view returns (uint256);

  function checkpoint() external;

  function commit_smart_wallet_checker(address) external;

  function apply_smart_wallet_checker() external;
}
