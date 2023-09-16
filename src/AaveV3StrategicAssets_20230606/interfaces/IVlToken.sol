// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

struct LockedBalance {
        uint112 amount;
        uint32 unlockTime;
    }

interface IVlToken {
    // Locked tokens cannot be withdrawn for lockDuration and are eligible to receive stakingReward rewards
    function lock(address _account, uint256 _amount) external;

    // claim all pending rewards
    function getReward(address _account) external;

    // Withdraw/relock all currently locked tokens where the unlock time has passed
    function processExpiredLocks(bool _relock) external;

    // @dev Delegate votes from the sender to `newDelegatee`.
    function delegate(address newDelegatee) external;

    // Withdraw without checkpointing or accruing any rewards, providing system is shutdown
    function emergencyWithdraw() external;

    // Information on a user's locked balances
    function lockedBalances(address _user)
        external
        view
        returns (
            uint256 total,
            uint256 unlockable,
            uint256 locked,
            LockedBalance[] memory lockData
        );
}
