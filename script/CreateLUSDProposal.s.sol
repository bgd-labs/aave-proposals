// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract LUSDPayloadProposal is CreateMainnetProposal {
  bytes32 internal IPFS_HASH = 0x2544be91c00601ccaf3824eaa990c4ba92b2c2652f21713de2c7d46eb8c848be;

  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x9D4948Be10dcE66C0F584A6C42Fd7d985786b439);
    vm.startBroadcast();
    GovHelpers.createProposal(payloads, IPFS_HASH);
    vm.stopBroadcast();
  }
}
