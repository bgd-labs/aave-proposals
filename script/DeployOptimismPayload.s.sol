// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {OpPayload} from '../src/contracts/optimism/OpPayload.sol';

contract DeployOptimismPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(10) {}
}

contract Op is DeployOptimismPayload {
  function run() external {
    vm.startBroadcast();
    new OpPayload();
    vm.stopBroadcast();
  }
}
