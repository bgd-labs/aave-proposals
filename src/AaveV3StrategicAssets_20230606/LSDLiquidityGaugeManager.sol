// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {ILiquidityGauge, ILiquidityGaugeController} from './interfaces/ILiquidityGauge.sol';
import {Core} from './Core.sol';

abstract contract LSDLiquidityGaugeManager is Core {
  event GaugeControllerChanged(address indexed oldController, address indexed newController);
  event GaugeRewardsClaimed(address indexed gauge, address indexed token, uint256 amount);
  event GaugeStake(address indexed gauge, uint256 amount);
  event GaugeUnstake(address indexed gauge, uint256 amount);
  event GaugeVote(address indexed gauge, uint256 amount);

  /// @notice Setting to the same controller address as currently set.
  error SameController();

  /// @notice Address of LSD to address of gauge controller mapping
  mapping(address tokenAddress => address) public gaugeControllers;

  /// @notice Set the gauge controller used for gauge weight voting
  /// @param token Address of the LSD token
  /// @param gaugeController The gauge controller address
  function setGaugeController(address token, address gaugeController) public onlyAdminOrManager {
    if (gaugeController == address(0)) revert Invalid0xAddress();

    address oldController = gaugeControllers[token];
    if (oldController == gaugeController) revert SameController();

    gaugeControllers[token] = gaugeController;

    emit GaugeControllerChanged(oldController, gaugeController);
  }

  /// @notice Vote for a gauge's weight
  /// @param token the address of the token to vote for
  /// @param gauge the address of the gauge to vote for
  /// @param weight the weight of gaugeAddress in basis points [0, 10.000]
  function voteForGaugeWeight(
    address token,
    address gauge,
    uint256 weight
  ) external onlyAdminOrManager {
    if (gauge == address(0)) revert Invalid0xAddress();

    ILiquidityGaugeController(gaugeControllers[token]).vote_for_gauge_weights(gauge, weight);
    emit GaugeVote(gauge, weight);
  }
}
