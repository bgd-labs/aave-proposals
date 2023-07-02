pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {PolygonScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolCRVRiskParams_20230702} from './AaveV3PolCRVRiskParams_20230702.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3PolCRVRiskParams_20230702/CHAOS-LABS-RISK-PARAMETERS-UPDATE-CRV-AAVE-V3-POLYGON.md'
      )
    );
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolCRVRiskParams_20230702();
  }
}
