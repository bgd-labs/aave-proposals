// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthFEIRiskParams_20230703} from 'src/AaveV2EthFEIRiskParams_20230703/AaveV2EthFEIRiskParams_20230703.sol';

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2EthFEIRiskParams_20230703();
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
        'src/AaveV2EthFEIRiskParams_20230703/CHAOS-LABS-RISK-PARAMETER-UPDATES-UPDATES-FEI-AAVE-V2-ETHEREUM.md'
      )
    );
  }
}
