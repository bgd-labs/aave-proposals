// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {ArbitrumScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Arb_Listings_20231107_Payload} from './AaveV3_Arb_Listings_20231107_Payload.sol';

/**
 * @dev Deploy AaveV3_Arb_Listings_20231107
 * command: make deploy-ledger contract=src/AaveV3_Arb_Listings_20231107/AaveV3_Arb_Listings_20231107.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    new AaveV3_Arb_Listings_20231107_Payload();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Arb_Listings_20231107/AaveV3_Arb_Listings_20231107.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildArbitrum(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Arb_Listings_20231107/Listings.md')
    );
  }
}
