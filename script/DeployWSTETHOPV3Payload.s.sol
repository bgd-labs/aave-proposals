// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3OPWSTETHPayload} from '../src/contracts/optimism/AaveV3OPWSTETHPayload.sol';

contract DeployV3OPWSTETHPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(10) {}
}

contract WSTETH is DeployV3OPWSTETHPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3OPWSTETHPayload();
    vm.stopBroadcast();
  }
}
