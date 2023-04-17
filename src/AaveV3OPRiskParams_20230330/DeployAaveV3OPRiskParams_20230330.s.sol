pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3OPRiskParams_20230330} from './AaveV3OPRiskParams_20230330.sol';
import 'aave-helpers/ScriptUtils.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0)); // fill in contract address
    GovHelpers.createProposal(payloads, ''); // fill in encodedHash
  }
}

contract DeployPayloadOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3OPRiskParams_20230330();
  }
}
