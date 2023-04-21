pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {PolygonScript,EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolCapsUpdate_20230421} from './AaveV3PolCapsUpdate_20230421.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0x33DeAc0861FD6a9235b86172AA939E79085c6f52);
    GovHelpers.createProposal(payloads, 0x8e036cb7b5c10028564ba8d16c19e1b8bda48fa41edb904caec571908a76b1d3);
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolCapsUpdate_20230421();
  }
}
