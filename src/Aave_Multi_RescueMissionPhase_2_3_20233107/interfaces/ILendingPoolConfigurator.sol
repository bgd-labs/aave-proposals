// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12;
pragma experimental ABIEncoderV2;

/**
 * @title ILendingPoolConfigurator interface
 */
interface ILendingPoolConfigurator {
  struct UpdateATokenInput {
    address asset;
    address treasury;
    address incentivesController;
    string name;
    string symbol;
    address implementation;
    bytes params;
  }

  function updateAToken(UpdateATokenInput calldata input) external;
}
