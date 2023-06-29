// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {ISdDepositor} from './interfaces/ISdDepositor.sol';
import {Core} from './Core.sol';

abstract contract SdTokenManager is Core {
  struct SdToken {
    /// @notice Address of SD Token
    address sdToken;
    /// @notice Address of locker to deposit SD Token
    address depositor;
  }

  mapping(address => SdToken) public sdTokens;

  /// @notice Locks underlying token into sdToken and stakes into gauge
  function lock(address underlying, uint256 amount) external onlyAdminOrManager {
    SdToken storage token = sdTokens[underlying];
    if (token.sdToken == address(0)) revert Invalid0xAddress();

    ISdDepositor(token.depositor).deposit(amount, true, true, address(this));
  }

  function retrieveUnderlying(address token) external onlyAdminOrManager {
    // TODO: Add curve swap? or COW? Nothing?
  }
}
