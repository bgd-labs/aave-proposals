// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

// import {AaveV3ArbCapsPayload} from '../src/contracts/arbitrum/AaveV3ArbCapsPayload.sol';

contract DeployArbitrumPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(42161) {}
}

// Example arbitrum contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract ArbCaps is DeployArbitrumPayload {
//   function run() external {
//     vm.startBroadcast();
//     new AaveV3ArbCapsPayload();
//     vm.stopBroadcast();
//   }
// }
