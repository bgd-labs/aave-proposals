// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {WithChainIdValidation} from './WithChainIdValidation.sol';

import {GHSTV3RiskParamPayload} from '../src/contracts/polygon/GHSTV3PolRiskParamPayload.sol';

contract DeployPolygonPayload is WithChainIdValidation {
  constructor() WithChainIdValidation(137) {}
}

contract GHST is DeployPolygonPayload {
  function run() external {
    vm.startBroadcast();
    new GHSTV3RiskParamPayload();
    vm.stopBroadcast();
  }
}
