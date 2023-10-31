// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  EthereumScript
} from 'aave-helpers/ScriptUtils.sol';
import {
  AaveV3EthereumUpdate20231024Payload
} from './AaveV3Ethereum_20231024.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3Update_20231024/AaveV3Update_20231024.md'
      )
    );
  }
}

contract Deploy20231024PayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3EthereumUpdate20231024Payload();
  }
}