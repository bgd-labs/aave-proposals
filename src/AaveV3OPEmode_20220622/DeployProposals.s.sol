// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3OPEmode_20220622_Payload} from './AaveV3OPEmode_20220622_Payload.sol';

contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3OPEmode_20220622_Payload();
  }
}

contract SinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3OPEmode_20220622/AIP-OPTIMISM-ETH-EMODE.md'));
  }
}
