// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ILiquidityGauge {
  function deposit(uint256 value) external;

  function withdraw(uint256 value, bool claim_rewards) external;

  function claim_rewards() external;

  function balanceOf(address) external view returns (uint256);

  // curve & balancer use lp_token()
  function lp_token() external view returns (address);

  // angle use staking_token()
  function staking_token() external view returns (address);

  function reward_tokens(uint256 i) external view returns (address token);

  function reward_count() external view returns (uint256 nTokens);
}

interface ILiquidityGaugeController {
  function vote_for_gauge_weights(address gauge_addr, uint256 user_weight) external;

  function last_user_vote(address user, address gauge) external view returns (uint256);

  function vote_user_power(address user) external view returns (uint256);

  function gauge_types(address gauge) external view returns (int128);

  function get_gauge_weight(address gauge) external view returns (uint256);
}
