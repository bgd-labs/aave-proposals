// Copyright 2021-2022, Offchain Labs, Inc.
// For license information, see https://github.com/nitro/blob/master/LICENSE
// SPDX-License-Identifier: BUSL-1.1

// solhint-disable-next-line compiler-version
pragma solidity >=0.6.9 <0.9.0;

interface IInbox {
  /**
   * @notice Put a message in the L2 inbox that can be reexecuted for some fixed amount of time if it reverts
   * @dev all msg.value will deposited to callValueRefundAddress on L2
   * @dev Gas limit and maxFeePerGas should not be set to 1 as that is used to trigger the RetryableData error
   * @param to destination L2 contract address
   * @param l2CallValue call value for retryable L2 message
   * @param maxSubmissionCost Max gas deducted from user's L2 balance to cover base submission fee
   * @param excessFeeRefundAddress gasLimit x maxFeePerGas - execution cost gets credited here on L2 balance
   * @param callValueRefundAddress l2Callvalue gets credited here on L2 if retryable txn times out or gets cancelled
   * @param gasLimit Max gas deducted from user's L2 balance to cover L2 execution. Should not be set to 1 (magic value used to trigger the RetryableData error)
   * @param maxFeePerGas price bid for L2 execution. Should not be set to 1 (magic value used to trigger the RetryableData error)
   * @param data ABI encoded data of L2 message
   * @return unique message number of the retryable transaction
   */
  function createRetryableTicket(
    address to,
    uint256 l2CallValue,
    uint256 maxSubmissionCost,
    address excessFeeRefundAddress,
    address callValueRefundAddress,
    uint256 gasLimit,
    uint256 maxFeePerGas,
    bytes calldata data
  ) external payable returns (uint256);

  /**
   * @notice Put a message in the L2 inbox that can be reexecuted for some fixed amount of time if it reverts
   * @dev Advanced usage only (does not rewrite aliases for excessFeeRefundAddress and callValueRefundAddress). createRetryableTicket method is the recommended standard.
   * @param destAddr destination L2 contract address
   * @param l2CallValue call value for retryable L2 message
   * @param maxSubmissionCost Max gas deducted from user's L2 balance to cover base submission fee
   * @param excessFeeRefundAddress maxgas x gasprice - execution cost gets credited here on L2 balance
   * @param callValueRefundAddress l2Callvalue gets credited here on L2 if retryable txn times out or gets cancelled
   * @param maxGas Max gas deducted from user's L2 balance to cover L2 execution
   * @param gasPriceBid price bid for L2 execution
   * @param data ABI encoded data of L2 message
   * @return unique id for retryable transaction (keccak256(requestID, uint(0) )
   */
  function unsafeCreateRetryableTicket(
    address destAddr,
    uint256 l2CallValue,
    uint256 maxSubmissionCost,
    address excessFeeRefundAddress,
    address callValueRefundAddress,
    uint256 maxGas,
    uint256 gasPriceBid,
    bytes calldata data
  ) external payable returns (uint256);
}
