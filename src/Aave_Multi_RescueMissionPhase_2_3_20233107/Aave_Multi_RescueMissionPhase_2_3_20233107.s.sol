// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2_Multi_RescueMissionPhase_2_3_20233107/AaveV2_Multi_RescueMissionPhase_2_3_20233107.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO:
    payloads[1] = GovHelpers.buildPolygon(address(0)); // TODO:
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV2_Multi_RescueMissionPhase_2_3_20233107/RescueMissionPhase_2_3.md'));
  }
}
