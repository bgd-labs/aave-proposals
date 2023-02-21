// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3EthCbETHCapsPayload} from '../src/contracts/mainnet/AaveV3EthCBETHCapsPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CBETH is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthCbETHCapsPayload();
    vm.stopBroadcast();
  }
}
