// SPDX-License-Identifier: MIT
// ################ EXAMPLE ################
// PLEASE COPY THE FILE & ADJUST ACCORDINGLY
//    WE WILL REMOVE SCRIPTS PERIODICALLY
// #########################################
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';

contract DeployPolygonPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(137) {}
}

contract MiMatic is DeployPolygonPayload {
  function run() external {
    vm.startBroadcast();
    new MiMaticPayload();
    vm.stopBroadcast();
  }
}
