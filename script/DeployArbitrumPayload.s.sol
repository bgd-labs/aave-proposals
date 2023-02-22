// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3ArbCapsPayload} from '../src/contracts/arbitrum/AaveV3ArbCapsPayload.sol';

contract DeployArbitrumPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(42161) {}
}

contract ArbCaps is DeployArbitrumPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3ArbCapsPayload();
    vm.stopBroadcast();
  }
}
