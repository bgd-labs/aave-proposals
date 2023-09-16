// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230817_AaveRobotActivation/AaveRobotActivation_20230817.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](4);
    payloads[0] = GovHelpers.buildMainnet(0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4);
    payloads[1] = GovHelpers.buildOptimism(0x67F0B21FB75B88a7553039631A2Bc796Fb89e0A4);
    payloads[2] = GovHelpers.buildArbitrum(0xdDE20B20E21a6F3b7080e740b684CDf5b764B80D);
    payloads[3] = GovHelpers.buildPolygon(0xdDE20B20E21a6F3b7080e740b684CDf5b764B80D);
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230817_AaveRobotActivation/AaveRobotActivation.md'));
  }
}
