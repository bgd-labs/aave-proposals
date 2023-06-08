// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3ETHrETHEmode_20230522} from './AaveV3ETHrETHEmode_20230522.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO: replace with actual payload
    GovHelpers.createProposal(payloads, ''); // TODO: replace with actual hash
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3ETHrETHEmode_20230522();
  }
}
