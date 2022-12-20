// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3ArbBorrowCapsPayload} from '../src/contracts/arbitrum/AaveV3ArbBorrowCapsPayload.sol';
import {AaveV3OptBorrowCapsPayload} from '../src/contracts/optimism/AaveV3OptBorrowCapsPayload.sol';
import {AaveV3PolBorrowCapsPayload} from '../src/contracts/polygon/AaveV3PolBorrowCapsPayload.sol';

contract DeployArbitrumCaps is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3ArbBorrowCapsPayload();
    vm.stopBroadcast();
  }
}

contract DeployOptimismCaps is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3OptBorrowCapsPayload();
    vm.stopBroadcast();
  }
}

contract DeployPolygonCaps is Script {
  function run() external {
    vm.startBroadcast();
    new AaveV3PolBorrowCapsPayload();
    vm.stopBroadcast();
  }
}
