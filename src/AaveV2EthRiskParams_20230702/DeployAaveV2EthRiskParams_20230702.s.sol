// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthRiskParams_20230702} from 'src/AaveV2EthRiskParams_20230702/AaveV2EthRiskParams_20230702.sol';

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2EthRiskParams_20230702();
  }
}

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload address
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2EthRiskParams_20230702/AAVE-V2-ETH-RISK-PARAMS-20230702.md'
      )
    );
  }
}
