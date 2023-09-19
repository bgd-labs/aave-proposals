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
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](3);
    payloads[0] = GovHelpers.buildMainnet(0x5d7e9a32E0c3db609089186bEBC4B9d8Eb86ad2c);
    payloads[1] = GovHelpers.buildPolygon(0x7B74938583Eb03e06042fcB651046BaF0bf15644);
    payloads[2] = GovHelpers.buildOptimism(0x7B74938583Eb03e06042fcB651046BaF0bf15644);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2_Multi_RescueMissionPhase_2_3_20233107/RescueMissionPhase_2_3.md'
      )
    );
  }
}
