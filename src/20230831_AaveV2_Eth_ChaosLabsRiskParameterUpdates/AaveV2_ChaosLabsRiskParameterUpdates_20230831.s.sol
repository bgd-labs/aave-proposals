// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831} from './AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831.sol';

/**
 * @dev Deploy AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831
 * command: make deploy-ledger contract=src/20230831_AaveV2_Eth_ChaosLabsRiskParameterUpdates/AaveV2_ChaosLabsRiskParameterUpdates_20230831.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230831_AaveV2_Eth_ChaosLabsRiskParameterUpdates/AaveV2_ChaosLabsRiskParameterUpdates_20230831.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230831_AaveV2_Eth_ChaosLabsRiskParameterUpdates/ChaosLabsRiskParameterUpdates.md'
      )
    );
  }
}
