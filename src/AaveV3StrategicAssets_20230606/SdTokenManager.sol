// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {ISdDepositor} from './interfaces/ISdDepositor.sol';
import {Core} from './Core.sol';

abstract contract SdTokenManager is Core {
  using SafeERC20 for IERC20;

  struct SdToken {
    /// @notice Address of SD Token
    address sdToken;
    /// @notice Address of locker to deposit SD Token
    address depositor;
  }

  mapping(address => SdToken) public sdTokens;

  /// @notice Locks underlying token into sdToken and stakes into gauge
  function lock(address underlying, uint256 amount) external onlyOwnerOrGuardian {
    SdToken storage token = sdTokens[underlying];
    if (token.sdToken == address(0)) revert Invalid0xAddress();

    IERC20(underlying).approve(token.depositor, amount);
    ISdDepositor(token.depositor).deposit(amount, true, true, address(this));
  }

  function retrieveUnderlying(address token) external onlyOwnerOrGuardian {
    // TODO: Add curve swap? or COW? Nothing?
  }
}
