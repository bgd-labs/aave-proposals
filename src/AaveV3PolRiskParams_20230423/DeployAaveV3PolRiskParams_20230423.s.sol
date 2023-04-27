pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {PolygonScript,EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolRiskParams_20230423} from './AaveV3PolRiskParams_20230423.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0)); // contract address
    GovHelpers.createProposal(payloads, 0); // AIP hash
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolRiskParams_20230423();
  }
}
