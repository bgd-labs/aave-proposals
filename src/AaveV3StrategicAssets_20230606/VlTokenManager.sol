// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {IVlToken, LockedBalance} from './interfaces/IVlToken.sol';
import {Common} from './Common.sol';

abstract contract VlTokenManager is Common {
  event ClaimVLAURARewards();
  event DelegatedVLAURA(address newDelegate);
  event EmergencyWithdraw(uint256 tokensUnlocked);
  event LockVLAURA(uint256 cummulativeTokensLocked, uint256 lockHorizon);
  event RelockVLAURA(uint256 cumulativeTokensLocked);
  event UnlockVLAURA(uint256 tokensUnlocked);

  address public constant AURA = 0xC0c293ce456fF0ED870ADd98a0828Dd4d2903DBF;
  address public constant VL_AURA = 0x3Fa73f1E5d8A792C80F426fc8F84FBF7Ce9bBCAC;

  function lockVLAURA(uint256 amount) external onlyOwnerOrGuardian {
    IERC20(AURA).approve(VL_AURA, amount);
    IVlToken(VL_AURA).lock(address(this), amount);

    emit LockVLAURA(amount, block.timestamp + IVlToken(VL_AURA).lockDuration());
  }

  function claimVLAURARewards() external onlyOwnerOrGuardian {
    IVlToken(VL_AURA).getReward(address(this));

    emit ClaimVLAURARewards();
  }

  function delegateVLAURA(address delegatee) external onlyOwnerOrGuardian {
    IVlToken(VL_AURA).delegate(delegatee);

    emit DelegatedVLAURA(delegatee);
  }

  function relockVLAURA() external onlyOwnerOrGuardian {
    (uint256 lockedBalance, , , ) = IVlToken(VL_AURA).lockedBalances(address(this));
    IVlToken(VL_AURA).processExpiredLocks(true);

    emit RelockVLAURA(lockedBalance);
  }

  function unlockVLAURA() external onlyOwnerOrGuardian {
    (uint256 lockedBalance, , , ) = IVlToken(VL_AURA).lockedBalances(address(this));
    IVlToken(VL_AURA).processExpiredLocks(false);

    emit UnlockVLAURA(lockedBalance);
  }

  function emergencyWithdrawVLAURA() external onlyOwnerOrGuardian {
    (uint256 lockedBalance, , , ) = IVlToken(VL_AURA).lockedBalances(address(this));
    IVlToken(VL_AURA).emergencyWithdraw();

    emit EmergencyWithdraw(lockedBalance);
  }
}
