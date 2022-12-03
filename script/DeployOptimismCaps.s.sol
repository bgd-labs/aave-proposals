// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3OptCapsPayload} from '../src/contracts/optimism/AaveV3OptCapsPayload.sol';

contract DeployOptimismCaps is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3OptCapsPayload();
    vm.stopBroadcast();
  }
}
