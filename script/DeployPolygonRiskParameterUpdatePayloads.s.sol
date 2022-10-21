// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {RiskParameterUpdateV2} from '../src/contracts/polygon/RiskParameterUpdateV2.sol';
import {RiskParameterUpdateV3} from '../src/contracts/polygon/RiskParameterUpdateV3.sol';

contract DeployRiskParameterUpdateV2 is Script {
  function run() external {
    vm.startBroadcast();
    new RiskParameterUpdateV2();
    vm.stopBroadcast();
  }
}

contract DeployRiskParameterUpdateV3 is Script {
  function run() external {
    vm.startBroadcast();
    new RiskParameterUpdateV3();
    vm.stopBroadcast();
  }
}
