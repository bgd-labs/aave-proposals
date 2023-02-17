// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3ArbLDOEmissionAdminPayload} from '../src/contracts/arbitrum/AaveV3ArbLDOEmissionAdminPayload.sol';
import {AaveV3EthLDOEmissionAdminPayload} from '../src/contracts/mainnet/AaveV3EthLDOEmissionAdminPayload.sol';
import {AaveV3OptLDOEmissionAdminPayload} from '../src/contracts/optimism/AaveV3OptLDOEmissionAdminPayload.sol';

contract DeployArbLDOEmissionAdmin is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3ArbLDOEmissionAdminPayload();
    vm.stopBroadcast();
  }
}

contract DeployMainnetLDOEmissionAdmin is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthLDOEmissionAdminPayload();
    vm.stopBroadcast();
  }
}

contract DeployOptLDOEmissionAdmin is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3OptLDOEmissionAdminPayload();
    vm.stopBroadcast();
  }
}
