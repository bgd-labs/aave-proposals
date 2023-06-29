// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface IAragonVoting {
  /**
   * @notice Vote a percentage value in favor of a vote
   * @dev Initialization check is implicitly provided by `voteExists()` as new votes can only be
   *      created via `newVote(),` which requires initialization
   * @param _voteData Packed vote data containing both voteId and the vote in favor percentage (where 0 is no, and 1e18 is yes)
   *          Vote data packing
   * |  yeaPct  |  nayPct  |   voteId  |
   * |  64b     |  64b     |   128b    |
   * @param _supports Whether voter supports the vote (preserved for backward compatibility purposes)
   * @param _executesIfDecided Whether the vote should execute its action if it becomes decided
   */
  function vote(uint256 _voteData, bool _supports, bool _executesIfDecided) external;
}
