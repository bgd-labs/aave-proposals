// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {USDCDepegRiskProtection} from '../src/contracts/avalanche/USDCDepegRiskProtection.sol';
import {USDCDepegRiskUnfreeze} from '../src/contracts/avalanche/USDCDepegRiskUnfreeze.sol';

contract DeployAvalanchePayload is WithChainIdValidation {
  constructor() WithChainIdValidation(43114) {}
}

contract USDCProtection is DeployAvalanchePayload {
  function run() external {
    vm.startBroadcast();
    new USDCDepegRiskProtection();
    vm.stopBroadcast();
  }
}

contract USDCUnfreeze is DeployAvalanchePayload {
  function run() external {
    vm.startBroadcast();
    new USDCDepegRiskUnfreeze();
    vm.stopBroadcast();
  }
}
