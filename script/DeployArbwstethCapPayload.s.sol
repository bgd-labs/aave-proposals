// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3ArbwstETHCapsPayload} from '../src/contracts/arbitrum/AaveV3ArbwstETHSupplyCapsPayload.sol';

contract DeployArbitrumPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(42161) {}
}

contract ArbwtstethSupplyCap is DeployArbitrumPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3ArbwstETHCapsPayload();
    vm.stopBroadcast();
  }
}
