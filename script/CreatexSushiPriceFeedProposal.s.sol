// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract SwapXSushiPriceFeedProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}

  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0x3105C276558Dd4cf7E7be71d73Be8D33bD18F211 // deployed swap xSushi price feed payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x62eecfcd8fa8264bf4c95014fbf3e4cc7bce8d91d1e58cede18de038660ea8be
    );
    vm.stopBroadcast();
  }
}
