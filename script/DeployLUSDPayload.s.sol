// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';
import {AaveV3EthLUSDPayload} from '../src/contracts/mainnet/AaveV3EthLusdPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract LUSD is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthLUSDPayload();
    vm.stopBroadcast();
  }
}
