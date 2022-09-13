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

library AddressAliasHelper {
  uint160 constant offset = uint160(0x1111000000000000000000000000000000001111);

  /// @notice Utility function that converts the address in the L1 that submitted a tx to
  /// the inbox to the msg.sender viewed in the L2
  /// @param l1Address the address in the L1 that triggered the tx to L2
  /// @return l2Address L2 address as viewed in msg.sender
  function applyL1ToL2Alias(address l1Address)
    internal
    pure
    returns (address l2Address)
  {
    unchecked {
      l2Address = address(uint160(l1Address) + offset);
    }
  }

  /// @notice Utility function that converts the msg.sender viewed in the L2 to the
  /// address in the L1 that submitted a tx to the inbox
  /// @param l2Address L2 address as viewed in msg.sender
  /// @return l1Address the address in the L1 that triggered the tx to L2
  function undoL1ToL2Alias(address l2Address)
    internal
    pure
    returns (address l1Address)
  {
    unchecked {
      l1Address = address(uint160(l2Address) - offset);
    }
  }
}
