// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  EthereumScript
} from 'aave-helpers/ScriptUtils.sol';
import {
  AaveV2EthereumUpdate20231009Payload
} from './AaveV2Ethereum_20231009.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xff374aD1be52fF54Cf576586253a113d3F48D4B7);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2Update_20231009/AaveV2Update_20231009.md'
      )
    );
  }
}

contract Deploy20231009PayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2EthereumUpdate20231009Payload();
  }
}
