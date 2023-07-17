// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

import {AaveV3CuratorPayload} from './AaveV3CuratorPayload.sol';

contract DeployAaveCuratorScript is EthereumScript {
  function run() external broadcast {
    new AaveV3CuratorPayload();
  }
}

contract CreateAaveCuratorProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveCurator/AAVE-CURATOR-LAUNCH.md'));
  }
}
