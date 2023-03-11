// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {USDCDepegRiskProtection} from '../src/contracts/avalanche/USDCDepegRiskProtection.sol';

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
