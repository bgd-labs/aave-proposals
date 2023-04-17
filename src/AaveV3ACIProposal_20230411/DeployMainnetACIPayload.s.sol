// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3ACIProposal_20230411} from 'src/AaveV3ACIProposal_20230411/AaveV3ACIProposal_20230411.sol';

contract DeployMainnetACIPayload is EthereumScript {
  function run() external broadcast {
    new AaveV3ACIProposal_20230411();
  }
}

contract ACIPayloadProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // deployed cbETH payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: Replace with actual hash
    );
  }
}
