// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Arb_ARBListing_20231207} from './AaveV3_Arb_ARBListing_20231207.sol';

/**
 * @dev Deploy AaveV3_Arb_ARBListing_20231207
 * command: make deploy-ledger contract=src/AaveV3_Arb_ARBListing_20231207/AaveV3_Arb_ARBListing_20231207.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arb_ARBListing_20231207();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Arb_ARBListing_20231207/AaveV3_Arb_ARBListing_20231207.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Arb_ARBListing_20231207/ARBListing.md'));
  }
}