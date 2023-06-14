pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthRiskParams_20230529} from './AaveV3EthRiskParams_20230529.sol';
import 'aave-helpers/ScriptUtils.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // fill in contract address
    GovHelpers.createProposal(payloads, ''); // fill in encodedHash
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3EthRiskParams_20230529();
  }
}
