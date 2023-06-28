// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2CRVRiskParams_20230621} from 'src/AaveV2CRVRiskParams_20230621/AaveV2CRVRiskParams_20230621.sol';

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2CRVRiskParams_20230621();
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
        'src/AaveV2CRVRiskParams_20230621/AAVE-V2-CRV-RISK-PARAMS-20230621.md'
      )
    );
  }
}
