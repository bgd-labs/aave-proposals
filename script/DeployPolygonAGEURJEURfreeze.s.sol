// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3PolFreezeAGEUR} from '../src/contracts/polygon/AaveV3PolFreezeAGEUR.sol';
import {AaveV3PolFreezeJEUR} from '../src/contracts/polygon/AaveV3PolFreezeJEUR.sol';

contract DeployAGEURPayload is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3PolFreezeAGEUR();
    vm.stopBroadcast();
  }
}

contract DeployJEURPayload is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3PolFreezeJEUR();
    vm.stopBroadcast();
  }
}
