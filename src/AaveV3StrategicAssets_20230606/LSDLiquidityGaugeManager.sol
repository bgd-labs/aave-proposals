// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {ILiquidityGaugeController} from './interfaces/ILiquidityGaugeController.sol';
import {Common} from './Common.sol';

abstract contract LSDLiquidityGaugeManager is Common {
  event GaugeControllerChanged(address indexed oldController, address indexed newController);
  event GaugeVote(address indexed gauge, uint256 amount);

  /// @notice Setting to the same controller address as currently set.
  error SameController();

  /// @notice Address of LSD Gauge Controller
  address public gaugeController;

  /// @notice Set the gauge controller used for gauge weight voting
  /// @param _gaugeController The gauge controller address
  function setGaugeController(address _gaugeController) public onlyOwnerOrGuardian {
    if (_gaugeController == address(0)) revert InvalidZeroAddress();

    address oldController = gaugeController;
    if (oldController == _gaugeController) revert SameController();

    gaugeController = _gaugeController;

    emit GaugeControllerChanged(oldController, gaugeController);
  }

  /// @notice Vote for a gauge's weight
  /// @param gauge the address of the gauge to vote for
  /// @param weight the weight of gaugeAddress in basis points [0, 10.000]
  function voteForGaugeWeight(address gauge, uint256 weight) external onlyOwnerOrGuardian {
    if (gauge == address(0)) revert InvalidZeroAddress();

    ILiquidityGaugeController(gaugeController).vote_for_gauge_weights(gauge, weight);
    emit GaugeVote(gauge, weight);
  }
}
