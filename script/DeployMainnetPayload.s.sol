// // SPDX-License-Identifier: MIT
// // ################ EXAMPLE ################
// // PLEASE COPY THE FILE & ADJUST ACCORDINGLY
// //    WE WILL REMOVE SCRIPTS PERIODICALLY
// // #########################################
// pragma solidity ^0.8.0;
// import {WithChainIdValidation} from './WithChainIdValidation.sol';

// import {AaveV3EthcbETHPayload} from '../src/contracts/mainnet/AaveV3EthcbETHPayload.sol';

// contract DeployMainnetPayload is WithChainIdValidation {
//   constructor() WithChainIdValidation(1) {}
// }

// contract CbETH is DeployMainnetPayload {
//   function run() external {
//     vm.startBroadcast();
//     new AaveV3EthcbETHPayload();
//     vm.stopBroadcast();
//   }
// }
