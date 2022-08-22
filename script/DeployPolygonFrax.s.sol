// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {FraxPayload} from '../src/contracts/polygon/FraxPayload.sol';

contract DeployPolygonFrax is Script {
  function run() external {
    vm.startBroadcast();
    new FraxPayload();
    vm.stopBroadcast();
  }
}
