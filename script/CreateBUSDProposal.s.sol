// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CreateBUSD is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xBbF4723d70043Fa338d8b519b041b476648902a6
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0xe8a784a9b0773932a347ed6f74027008c088f76ac0165b97d6e78e4d46903f57
    );
    vm.stopBroadcast();
  }
}