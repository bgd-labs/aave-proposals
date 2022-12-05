// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * Mock contract which allows performing a delegatecall to `execute`
 * Intended to me used as replacement for L2 admins to mock governance/gnosis execution.
 */
contract MockExecutor {
  function execute(address payload) public {
    (bool success, ) = address(payload).delegatecall(
      abi.encodeWithSignature('execute()')
    );
    require(success, 'PROPOSAL_EXECUTION_FAILED');
  }
}
