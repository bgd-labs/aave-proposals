// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

// import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';

contract DeployPolygonPayload {
  function _nwCheck() internal {
    require(block.chainid == 137, 'POLYGON_ONLY');
  }
}

// Example polygon contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract MiMatic is DeployPolygonPayload {
//   function run() external {
//     _nwCheck();

//     vm.startBroadcast();
//     new MiMaticPayload();
//     vm.stopBroadcast();
//   }
// }
