// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {AaveV3AvaxWAVAXInterestRatePayload} from '../src/contracts/avalanche/AaveV3AvaxWAVAXInterestRatePayload.sol';

contract DeployAvalanchePayload is WithChainIdValidation {
  constructor() WithChainIdValidation(43114) {}
}

contract DeployWAVAXIRPayload is DeployAvalanchePayload {
  function run() external {
    vm.startBroadcast();
    new AaveV3AvaxWAVAXInterestRatePayload();
    vm.stopBroadcast();
  }
}
