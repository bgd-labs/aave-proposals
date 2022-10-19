// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {CrosschainForwarderOptimism} from '../src/contracts/optimism/CrosschainForwarderOptimism.sol';

contract DeployOptimismForwarder is Script {
  function run() external {
    vm.startBroadcast();
    new CrosschainForwarderOptimism();
    vm.stopBroadcast();
  }
}
