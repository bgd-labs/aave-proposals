// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

// Example proposal creation script for a single payload
contract SinglePayloadProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x05097b8a0818a75c1db7d54dfd0299581cac0218a058017acb4726f7cc49657e // TODO: Replace with actual hash
    );
    vm.stopBroadcast();
  }
}

// Example proposal creation script for a single payload emitting the creation calldata
contract SafeSinglePayloadProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x05097b8a0818a75c1db7d54dfd0299581cac0218a058017acb4726f7cc49657e, // TODO: Replace with actual hash
      true
    );
    vm.stopBroadcast();
  }
}

// Example proposal creation script for a multiple payloads payload
contract MultiPayloadProposal is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    payloads[1] = GovHelpers.buildPolygon(
      0xd91d1331db4F436DaF47Ec9Dd86deCb8EEF946B4 // deployed cbETH payload
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0x05097b8a0818a75c1db7d54dfd0299581cac0218a058017acb4726f7cc49657e
    );
    vm.stopBroadcast();
  }
}
