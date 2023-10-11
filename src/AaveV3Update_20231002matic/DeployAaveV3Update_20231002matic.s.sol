// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  EthereumScript,
  PolygonScript
} from 'aave-helpers/ScriptUtils.sol';
import {
  AaveV3PolygonUpdate20231002maticPayload
} from './AaveV3Polygon_20231002matic.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0xff374aD1be52fF54Cf576586253a113d3F48D4B7);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3Update_20231002matic/AaveV3Update_20231002matic.md'
      )
    );
  }
}

contract Deploy20231002maticPayloadPolygon is PolygonScript {
  function run() external broadcast {
    new AaveV3PolygonUpdate20231002maticPayload();
  }
}
