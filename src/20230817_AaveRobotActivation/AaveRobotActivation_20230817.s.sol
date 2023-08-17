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
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO:
    payloads[0] = GovHelpers.buildOptimism(address(0)); // TODO:
    payloads[0] = GovHelpers.buildArbitrum(address(0)); // TODO:
    payloads[0] = GovHelpers.buildPolygon(address(0)); // TODO:
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230817_AaveRobotActivation/AaveRobotActivation.md'));
  }
}
