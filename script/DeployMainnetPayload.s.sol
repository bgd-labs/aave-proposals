// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

// import {AaveV3EthcbETHPayload} from '../src/contracts/mainnet/AaveV3EthcbETHPayload.sol';
import {AaveV3EthrETHPayload} from '../src/contracts/mainnet/AaveV3EthrETHPayload.sol';
import {AaveV2SwapxSushiPriceFeedPayload} from '../src/contracts/mainnet/AaveV2SwapxSushiPriceFeedPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

// Example mainnet contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

// contract CbETH is DeployMainnetPayload {
//   function run() external {
//     vm.startBroadcast();
//     new AaveV3EthcbETHPayload();
//     vm.stopBroadcast();
//   }
// }

contract rETH is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthrETHPayload();
    vm.stopBroadcast();
  }
}

contract AaveV2SwapxSushiOracle is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV2SwapxSushiPriceFeedPayload();
    vm.stopBroadcast();
  }
}
