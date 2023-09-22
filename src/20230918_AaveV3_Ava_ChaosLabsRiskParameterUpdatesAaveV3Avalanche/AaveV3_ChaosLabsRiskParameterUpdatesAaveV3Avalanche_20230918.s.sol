// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918} from './AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.sol';

/**
 * @dev Deploy AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918
 * command: make deploy-ledger contract=src/20230918_AaveV3_Ava_ChaosLabsRiskParameterUpdatesAaveV3Avalanche/AaveV3_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    new AaveV3_Avalanche_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230918_AaveV3_Ava_ChaosLabsRiskParameterUpdatesAaveV3Avalanche/AaveV3_ChaosLabsRiskParameterUpdatesAaveV3Avalanche_20230918.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](0);

    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230918_AaveV3_Ava_ChaosLabsRiskParameterUpdatesAaveV3Avalanche/ChaosLabsRiskParameterUpdatesAaveV3Avalanche.md'
      )
    );
  }
}
