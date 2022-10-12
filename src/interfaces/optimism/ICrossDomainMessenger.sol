// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 <0.9.0;

/**
 * @title ICrossDomainMessenger
 */
interface ICrossDomainMessenger {
  /**********
   * Events *
   **********/

  event SentMessage(
    address indexed target,
    address sender,
    bytes message,
    uint256 messageNonce,
    uint256 gasLimit
  );
  event RelayedMessage(bytes32 indexed msgHash);
  event FailedRelayedMessage(bytes32 indexed msgHash);

  /*************
   * Variables *
   *************/

  function xDomainMessageSender() external view returns (address);

  /********************
   * Public Functions *
   ********************/

  /**
   * Sends a cross domain message to the target messenger.
   * @param _target Target contract address.
   * @param _message Message to send to the target.
   * @param _gasLimit Gas limit for the provided message.
   */
  function sendMessage(
    address _target,
    bytes calldata _message,
    uint32 _gasLimit
  ) external;
}

/**
 * @title IL2CrossDomainMessenger
 */
interface IL2CrossDomainMessenger is ICrossDomainMessenger {
  /********************
   * Public Functions *
   ********************/

  /**
   * Relays a cross domain message to a contract.
   * @param _target Target contract address.
   * @param _sender Message sender address.
   * @param _message Message to send to the target.
   * @param _messageNonce Nonce for the provided message.
   */
  function relayMessage(
    address _target,
    address _sender,
    bytes memory _message,
    uint256 _messageNonce
  ) external;
}
