// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICrossDomainMessenger} from '../../interfaces/optimism/ICrossDomainMessenger.sol';

/**
 * @title A generic executor for proposals targeting the optimism v3 market
 * @author BGD Labs
 * @notice You can **only** use this executor when the optimism payload has a `execute()` signature without parameters
 * @notice You can **only** use this executor when the optimism payload is expected to be executed via `DELEGATECALL`
 * @dev This executor is a generic wrapper to be used with Optimism CrossDomainManager (https://etherscan.io/address/0x25ace71c97b33cc4729cf772ae268934f7ab5fa1)
 * It encodes a parameterless `execute()` with delegate calls and a specified target.
 * This encoded abi is then wrapped into a queue call which is send to the CrossDomainManager which is queueing the proposal on the POLYGON_BRIDGE_EXECUTOR.
 */
contract CrosschainForwarderOptimism {
  address public constant L1_CROSS_DOMAIN_MESSANGER_ADDRESS =
    0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1;
  address public constant OPTIMISM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;

  /**
   * @dev this function will be executed once the proposal passes the mainnet vote.
   * @param l2PayloadContract the polygon contract containing the `execute()` signature.
   */
  function execute(address l2PayloadContract) public {
    address[] memory targets = new address[](1);
    targets[0] = l2PayloadContract;
    uint256[] memory values = new uint256[](1);
    values[0] = 0;
    string[] memory signatures = new string[](1);
    signatures[0] = 'execute()';
    bytes[] memory calldatas = new bytes[](1);
    calldatas[0] = '';
    bool[] memory withDelegatecalls = new bool[](1);
    withDelegatecalls[0] = true;

    bytes memory queue = abi.encodeWithSelector(
      bytes4(keccak256('queue(address[],uint256[],string[],bytes[],bool[])')),
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls
    );
    ICrossDomainMessenger(L1_CROSS_DOMAIN_MESSANGER_ADDRESS).sendMessage(
      OPTIMISM_BRIDGE_EXECUTOR,
      queue,
      1920000
    );
  }
}
