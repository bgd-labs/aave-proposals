// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {OpPayload} from '../src/contracts/optimism/OpPayload.sol';

contract DeployOptimismOp is Script {
  function run() external {
    vm.startBroadcast();
    new OpPayload();
    vm.stopBroadcast();
  }
}
