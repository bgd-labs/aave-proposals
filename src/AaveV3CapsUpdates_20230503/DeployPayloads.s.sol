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
      address(0) // deployed AGD payload
    );
    payloads[1] = GovHelpers.buildPolygon(
      address(0) // deployed MaticX payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: Replace with actual hash
    );
  }
}
