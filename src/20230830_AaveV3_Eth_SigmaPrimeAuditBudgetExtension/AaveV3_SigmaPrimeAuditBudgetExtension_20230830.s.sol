// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830} from './AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830.sol';

/**
 * @dev Deploy AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830
 * command: make deploy-ledger contract=src/20230830_AaveV3_Eth_SigmaPrimeAuditBudgetExtension/AaveV3_SigmaPrimeAuditBudgetExtension_20230830.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_SigmaPrimeAuditBudgetExtension_20230830();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230830_AaveV3_Eth_SigmaPrimeAuditBudgetExtension/AaveV3_SigmaPrimeAuditBudgetExtension_20230830.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0x2aD4d4c989c4808439434cb556e1Be1c55105aaf));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230830_AaveV3_Eth_SigmaPrimeAuditBudgetExtension/SigmaPrimeAuditBudgetExtension.md'
      )
    );
  }
}
