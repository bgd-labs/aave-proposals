pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

// Example proposal creation script for a single payload
contract LUSD is CreateMainnetProposal {
  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(
      address(0) // TODO: Replace with actual address
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      0 // TODO: Replace with actual hash
    );
    vm.stopBroadcast();
  }
}