// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_TreasuryManagement_20230308} from './AaveV2_Eth_TreasuryManagement_20230308.sol';

/**
 * @dev Deploy AaveV2_Eth_TreasuryManagement_20230308
 * command: make deploy-ledger contract=src/AaveV2_Eth_TreasuryManagement_20230308/AaveV2_Eth_TreasuryManagement_20230308.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_TreasuryManagement_20230308();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2_Eth_TreasuryManagement_20230308/AaveV2_Eth_TreasuryManagement_20230308.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xEa7c5a54453bB31BBd53C87ecd5Dd7FF65839FC1);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2_Eth_TreasuryManagement_20230308/TreasuryManagement.md'
      )
    );
  }
}
