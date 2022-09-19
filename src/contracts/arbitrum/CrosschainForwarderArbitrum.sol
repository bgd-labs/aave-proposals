// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IInbox} from '../../interfaces/arbitrum/IInbox.sol';

/**
 * @title A generic executor for proposals targeting the arbitrum v3 market
 * @author BGD Labs
 * @notice You can **only** use this executor when the arbitrum payload has a `execute()` signature without parameters
 * @notice You can **only** use this executor when the arbitrum payload is expected to be executed via `DELEGATECALL`
 * @dev This executor is a generic wrapper to be used with Arbitrum Inbox (https://developer.offchainlabs.com/arbos/l1-to-l2-messaging#address-aliasing)
 * It encodes a parameterless `execute()` with delegate calls and a specified target.
 * This encoded abi is then send to the Inbox to be synced to the FX-child on the polygon network.
 * Once synced the POLYGON_BRIDGE_EXECUTOR will queue the execution of the payload.
 */
contract CrosschainForwarderArbitrum {
  address public constant INBOX_ADDRESS =
    0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  address public constant ARBITRUM_BRIDGE_EXECUTOR =
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
    IInbox(INBOX_ADDRESS).createRetryableTicket(
      ARBITRUM_BRIDGE_EXECUTOR,
      0, // l2CallValue
      0, // maxSubmissionCost
      address(0), // excessFeeRefundAddress
      address(0), // callValueRefundAddress
      600000, // gasLimit
      0, // maxFeePerGas
      queue
    );
  }
}
