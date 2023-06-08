// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3PolCapsUpdates_20230610_Payload} from 'src/AaveV3CapsUpdates_20230610/AaveV3PolCapsUpdates_20230610_Payload.sol';

contract DeployMainnetPayload is PolygonScript {
  function run() external broadcast {
    new AaveV3PolCapsUpdates_20230610_Payload();
  }
}

contract PayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildPolygon(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3CapsUpdates_20230610/AAVE-V3-POL-CAPS-UPDATES-20230610.md'
      )
    );
  }
}
