// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';

contract CreateMainnetProposal is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract USDTV3EthPayloadProposal is CreateMainnetProposal {
  address internal constant PAYLOAD = 0x3B45bbC2b69faFAB95fD91B10f39ccb5Dd92FaCb; // deployed USDT payload
  bytes32 internal constant IPFS_HASH =
    0x808868979965100b100d66218d024cb4a3dbde566bd6f4f0530141f42cf97f74;

  function run() external {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(PAYLOAD);
    vm.startBroadcast();
    GovHelpers.createProposal(payloads, IPFS_HASH);
    vm.stopBroadcast();
  }
}
