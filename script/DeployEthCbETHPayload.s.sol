// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV3EthCbETHSupplyCapsPayload} from '../src/contracts/mainnet/AaveV3EthCBETHSupplyCapsPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract CbETH is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthCbETHSupplyCapsPayload();
    vm.stopBroadcast();
  }
}
