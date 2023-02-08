// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV3EthrETHPayload} from '../src/contracts/mainnet/AaveV3EthrETHPayload.sol';

contract DeployMainnetPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(1) {}
}

/// @notice Script to deploy AaveV3EthrETHPayload

contract CbETH is DeployMainnetPayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3EthrETHPayload();
    vm.stopBroadcast();
  }
}
