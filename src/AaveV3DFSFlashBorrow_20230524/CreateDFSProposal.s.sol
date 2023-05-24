// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

contract DFSProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildOptimism(
      0x510B59f8258cF0BBeCA9477Fc774001B58DF9A09
    );
    GovHelpers.createProposal(
      payloads,
      0 // TODO: replace with actual hash
    );
  }
}
