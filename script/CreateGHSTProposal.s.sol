// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract GHSTPolProposal is CreateMainnetProposal {
  bytes32 internal IPFS_HASH = 0xe6be54663d94d7012909b7237da14661be98e50a773fa4b6c724c8ee966872dd;

  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xA0A864D3B0837e4806A91647C6aD382A7F73E1a8
    );
    vm.startBroadcast();
    GovHelpers.createProposal(
      payloads,
      IPFS_HASH
    );
    vm.stopBroadcast();
  }
}
