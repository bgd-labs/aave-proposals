// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';

contract DeployPolygonMiMatic is Script {
  function run() external {
    vm.startBroadcast();
    new MiMaticPayload();
    vm.stopBroadcast();
  }
}
