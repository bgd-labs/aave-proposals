// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

import {StrategicAssetsManagerPayload} from './StrategicAssetsManagerPayload.sol';

contract DeployAssetManagementContracts is EthereumScript {
  function run() external broadcast {
    new StrategicAssetsManagerPayload();
  }
}

contract SinglePayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3StrategicAssets_20230606/AIP-STRATEGIC-ASSETS-MANAGER.md'
      )
    );
  }
}
