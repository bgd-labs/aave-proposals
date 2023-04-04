// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3AvaxRescueExploitedPayload} from '../src/contracts/avalanche/AaveV3AvaxRescueExploitedPayload.sol';

contract DeployAvalanchePayload is WithChainIdValidation {
  constructor() WithChainIdValidation(43114) {}
}

contract AvaxRescue is DeployAvalanchePayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3AvaxRescueExploitedPayload();
    vm.stopBroadcast();
  }
}
