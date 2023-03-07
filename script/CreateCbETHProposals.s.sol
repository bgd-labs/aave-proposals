// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

// Example proposal creation script for a single payload
contract CBETHSupplyCapProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xB6E50599ba78c6cCd40dF8B903e3d76AE68dcc83
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x4f14b29139a93f1169afd329f5f7b9f5e8d8e55a252747c18ad50b23e9d1e249
    );
    vm.stopBroadcast();
  }
}
