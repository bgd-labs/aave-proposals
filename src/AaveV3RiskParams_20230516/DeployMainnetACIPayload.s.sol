// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3RiskParams_20230516} from 'src/AaveV3RiskParams_20230516/AaveV3RiskParams_20230516.sol';

contract DeployMainnetACIPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3RiskParams_20230516();
  }
}

contract ACIPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: Replace by actual payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: replace by actual Hash
    );
  }
}
