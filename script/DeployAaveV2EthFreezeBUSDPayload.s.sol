// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV2EthFreezeBUSD} from '../src/contracts/mainnet/AaveV2EthFreezeBUSD.sol';


contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract freezeBUSD is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV2EthFreezeBUSD();
    vm.stopBroadcast();
  }
}