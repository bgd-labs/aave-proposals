// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV3EthCBETHSupplyCapsPayload_29032023} from '../src/contracts/mainnet/AaveV3EthCBETHSupplyCapsPayload_29032023.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CbETH is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthCBETHSupplyCapsPayload_29032023();
    vm.stopBroadcast();
  }
}
