// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3StrategicAssets_20220622Payload} from './AaveV3StrategicAssets_20220622Payload.sol';

contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3StrategicAssets_20220622Payload();
  }
}

contract SinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xE5b5B70f9A5CCc2841f9FaCBb0c5C6030e68F341);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3StrategicAssets_20230622/AIP-ACQUIRE-WSTETH-RETH.md')
    );
  }
}
