// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, MetisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Met_SetEmissionManager_20232607} from './AaveV3_Met_SetEmissionManager_20232607.sol';

/**
 * @dev Deploy AaveV3_Met_SetEmissionManager_20232607
 * command: make deploy-ledger contract=src/AaveV3_Met_SetEmissionManager_20232607/AaveV3_Met_SetEmissionManager_20232607.s.sol:DeployMetis chain=metis
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    new AaveV3_Met_SetEmissionManager_20232607();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Met_SetEmissionManager_20232607/AaveV3_Met_SetEmissionManager_20232607.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMetis(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV3_Met_SetEmissionManager_20232607/SetEmissionManager.md'
      )
    );
  }
}
