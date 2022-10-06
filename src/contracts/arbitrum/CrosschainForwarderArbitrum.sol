// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IInbox} from '../../interfaces/arbitrum/IInbox.sol';
import {IL2BridgeExecutor} from '../../interfaces/IL2BridgeExecutor.sol';

/**
 * @title A generic executor for proposals targeting the arbitrum v3 market
 * @author BGD Labs
 * @notice You can **only** use this executor when the arbitrum payload has a `execute()` signature without parameters
 * @notice You can **only** use this executor when the arbitrum payload is expected to be executed via `DELEGATECALL`
 * @notice This contract assumes to be called via AAVE Governance V2
 * @notice This contract will assume the SHORT_EXECUTOR will be topped up with enough funds to fund the short executor
 * @dev This executor is a generic wrapper to be used with Arbitrum Inbox (https://developer.offchainlabs.com/arbos/l1-to-l2-messaging)
 * It encodes a parameterless `execute()` with delegate calls and a specified target.
 * This encoded abi is then send to the Inbox to be synced executed on the arbitrum network.
 * Once synced the ARBITRUM_BRIDGE_EXECUTOR will queue the execution of the payload.
 */
contract CrosschainForwarderArbitrum {
  address public constant INBOX_ADDRESS =
    0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;
  address public constant ARBITRUM_BRIDGE_EXECUTOR =
    0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;
  address public constant ARBITRUM_GUARDIAN =
    0xbbd9f90699c1FA0D7A65870D241DD1f1217c96Eb;

  uint256 public constant MESSAGE_LENGTH = 580;

  /**
   * @dev this function will be executed once the proposal passes the mainnet vote.
   * @param l2PayloadContract the arbitrum contract containing the `execute()` signature.
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
      IL2BridgeExecutor.queue.selector,
      targets,
      values,
      signatures,
      calldatas,
      withDelegatecalls
    );
    // As it's always the same encoded message (just address changing) length will always be the same
    // TODO: probably makes sense to add a margin to basefee?
    uint256 maxSubmission = (1400 + 6 * MESSAGE_LENGTH) * block.basefee;
    IInbox(INBOX_ADDRESS).unsafeCreateRetryableTicket{value: maxSubmission}(
      ARBITRUM_BRIDGE_EXECUTOR,
      0, // l2CallValue
      maxSubmission, // maxSubmissionCost
      address(ARBITRUM_BRIDGE_EXECUTOR), // excessFeeRefundAddress
      address(ARBITRUM_GUARDIAN), // callValueRefundAddress
      0, // gasLimit
      0, // maxFeePerGas
      queue
    );
  }
}
