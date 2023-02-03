// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

// import {MiMaticPayload} from '../src/contracts/polygon/MiMaticPayload.sol';

contract DeployPolygonPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(137) {}
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
