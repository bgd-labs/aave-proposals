// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

// import {AaveV3EthcbETHPayload} from '../src/contracts/mainnet/AaveV3EthcbETHPayload.sol';

contract DeployMainnetPayload {
  function _nwCheck() internal {
    require(block.chainid == 1, 'MAINNET_ONLY');
  }
}

// Example mainnet contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract CbETH is DeployMainnetPayload {
//   function run() external {
//     _nwCheck();

//     vm.startBroadcast();
//     new AaveV3EthcbETHPayload();
//     vm.stopBroadcast();
//   }
// }
