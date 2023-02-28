// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

// Creates Proposal for Rescue Short Executor Payload
contract RescueShortProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0x4A4c73d563395ad827511F70097d4Ef82E653805 // deployed rescue short executor payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0xb18d1b78952b06a25f58436d1de2e9c24cd2ede7872ce6339736c454ca281910
    );
    vm.stopBroadcast();
  }
}

// Creates Proposal for Rescue Long Executor Payload
contract RescueLongProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0x889c0cc3283DB588A34E89Ad1E8F25B0fc827b4b // deployed rescue long executor payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      AaveGovernanceV2.LONG_EXECUTOR,
      payloads,
      0x1dfccf185223e34bb5494d048f9c524f92fac5e3fad63ed173e6cbeed8f667bb
    );
    vm.stopBroadcast();
  }
}
