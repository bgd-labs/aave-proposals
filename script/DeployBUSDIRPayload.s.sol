// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV2BUSDPayload} from '../src/contracts/mainnet/AaveV2BUSDPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

contract BUSD is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV2BUSDPayload();
    vm.stopBroadcast();
  }
}
