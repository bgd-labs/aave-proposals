// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Eth_BugBounty_20230710} from './AaveV3_Eth_BugBounty_20230710.sol';

/**
 * @dev Deploy AaveV3_Eth_BugBounty_20230710
 * command: make deploy-ledger contract=src/AaveV3_Eth_BugBounty_20230710/AaveV3_Eth_BugBounty_20230710.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Eth_BugBounty_20230710();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Eth_BugBounty_20230710/AaveV3_Eth_BugBounty_20230710.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO: Deployed address
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Eth_BugBounty_20230710/BugBounty.md'));
  }
}