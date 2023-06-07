// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2PolygonIR_20230519} from './AaveV2PolygonIR_20230519.sol';

contract DeployPolygonPayload is PolygonScript {
  function run() external broadcast {
    new AaveV2PolygonIR_20230519();
  }
}

contract DeployProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(0x7e1f23bdFc7287AF276F77B5A867e85cf0377a31);
    GovHelpers.createProposal(
      payloads,
      0x6b4f7ccdc5173b9aa95e3e6b43d08cd9691f2486d465108b34e90aa3b0c63fc1
    );
  }
}
