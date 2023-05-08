// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230503_Payload} from 'src/AaveV3CapsUpdates_20230503/AaveV3PolCapsUpdates_20230503_Payload.sol';
import {AaveV2EthAGDGrantsPayload} from 'src/AaveV3CapsUpdates_20230503/AaveV2EthAGDGrantsPayload.sol';

contract DeployPolygonPayload is PolygonScript {
  function run() external broadcast {
    new AaveV3PolCapsUpdates_20230503_Payload();
  }
}

contract DeployMainnetPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2EthAGDGrantsPayload();
  }
}

contract DeployProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(
      0x7BE4FA90565d6fd6F7091d0af9E5a7F9CD7918A6
    );
    payloads[1] = GovHelpers.buildPolygon(
      0x22C669EEDf6e58De81777692B070CDB7432A4F84
    );
    GovHelpers.createProposal(
      payloads,
      0xa3267468b4d12df2ded6b48eea658134acfb9e512b2b34ca9299fde49062531f
    );
  }
}
