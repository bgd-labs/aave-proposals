pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {PolygonScript,EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolCapsUpdate_20230421} from './AaveV3PolCapsUpdate_20230421.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildPolygon(0x33DeAc0861FD6a9235b86172AA939E79085c6f52);
    // Deployed in an earlier proposal as part of the 03/27/2023 caps update
    payloads[1] = GovHelpers.buildArbitrum(0x4c68fDA91bfb4683eAB90017d9B76a99F2d77Eed);
    GovHelpers.createProposal(payloads, 0x3fbea0de2bd356382509565e0500cc73b102a4761976bcc409bd8636faa90b0a);
  }
}

contract DeployPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolCapsUpdate_20230421();
  }
}
