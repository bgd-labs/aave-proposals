// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CBETHEmodeProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0x2B6dE4f5a2a78F35D65d0D03BF4f12FFb2A26CBc
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x8c43863eb45efe9d794f07cf717a3f71d8fc315f693d42dff0f681e839d1419d
    );
    vm.stopBroadcast();
  }
}
