// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

// import {OpPayload} from '../src/contracts/optimism/OpPayload.sol';

contract DeployOptimismPayload {
  function _nwCheck() internal {
    require(block.chainid == 10, 'OPTIMISM_ONLY');
  }
}

// Example optimism contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract Op is DeployOptimismPayload {
//   function run() external {
//     _nwCheck();

//     vm.startBroadcast();
//     new OpPayload();
//     vm.stopBroadcast();
//   }
// }
