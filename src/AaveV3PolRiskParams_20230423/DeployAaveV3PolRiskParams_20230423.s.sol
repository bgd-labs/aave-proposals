pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {PolygonScript,EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolRiskParams_20230423} from './AaveV3PolRiskParams_20230423.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(address(0xc53586AA2626094bD33C123794E34417ea877a36));
    GovHelpers.createProposal(payloads, 0x0534109ab793da6816093b041e5f1685ed1f2523ad69c7e734a85a5bcf22895b); 
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolRiskParams_20230423();
  }
}
