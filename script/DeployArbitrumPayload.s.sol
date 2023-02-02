// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

// import {AaveV3ArbCapsPayload} from '../src/contracts/arbitrum/AaveV3ArbCapsPayload.sol';

contract DeployArbitrumPayload {
  function _nwCheck() internal {
    require(block.chainid == 42161, 'ARBITRUM_ONLY');
  }
}

// Example arbitrum contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract ArbCaps is DeployArbitrumPayload {
//   function run() external {
//     _nwCheck();

//     vm.startBroadcast();
//     new AaveV3ArbCapsPayload();
//     vm.stopBroadcast();
//   }
// }
