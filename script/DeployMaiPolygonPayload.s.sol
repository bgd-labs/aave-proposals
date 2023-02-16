// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {MAIV3PolCapsPayload} from '../src/contracts/polygon/MaiV3PolCapsPayload.sol';

contract DeployPolygonPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(137) {}
}

contract MAI is DeployPolygonPayload {
  function run() external {
    vm.startBroadcast();
    new MAIV3PolCapsPayload();
    vm.stopBroadcast();
  }
}
