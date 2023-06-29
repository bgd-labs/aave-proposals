// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface DelegateRegistry {
  function setDelegate(bytes32 id, address delegate) external;

  function clearDelegate(bytes32 id) external;

  function delegation(address delegator, bytes32 id) external view returns (address delegatee);
}
