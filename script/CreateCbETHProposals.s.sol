// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CBETHSupplyCapProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xB6E50599ba78c6cCd40dF8B903e3d76AE68dcc83
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x2426029bb07fa6f4c7c60d427f63abbca45cf592822b01c3f7910f3735560c2b
    );
    vm.stopBroadcast();
  }
}
