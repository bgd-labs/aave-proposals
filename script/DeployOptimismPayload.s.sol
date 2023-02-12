// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

// import {OpPayload} from '../src/contracts/optimism/OpPayload.sol';

contract DeployOptimismPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(10) {}
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
