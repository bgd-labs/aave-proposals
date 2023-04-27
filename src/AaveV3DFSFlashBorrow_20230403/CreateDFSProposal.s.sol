// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

contract DFSProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO: replace with deployed payload
    );
    payloads[1] = GovHelpers.buildArbitrum(
      address(0) // TODO: replace with deployed payload
    );
    payloads[2] = GovHelpers.buildOptimism(
      address(0) // TODO: replace with deployed payload
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: replace with actual hash
    );
  }
}
