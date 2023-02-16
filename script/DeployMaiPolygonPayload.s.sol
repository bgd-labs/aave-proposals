// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {MAIV3PolCapsPayload} from '../src/contracts/polygon/MaiV3PolCapsPayload.sol';

contract DeployPolygonPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(137) {}
}

// Example polygon contract deployment
// copy and replace with the contract you are planning to deploy
// we'll periodically cleanup scripts comitted here

contract MAI is DeployPolygonPayload {
  function run() external {
    // _nwCheck();

    vm.startBroadcast();
    new MAIV3PolCapsPayload();
    vm.stopBroadcast();
  }
}
