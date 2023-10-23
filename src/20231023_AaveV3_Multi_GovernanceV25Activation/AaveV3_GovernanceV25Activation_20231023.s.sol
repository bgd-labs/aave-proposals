// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231023_AaveV3_Multi_GovernanceV25Activation/AaveV3_GovernanceV25Activation_20231023.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](6);
    payloads[0] = GovHelpers.buildMainnet(0xE40E84457F4b5075f1EB32352d81ecF1dE77fee6);
    payloads[1] = GovHelpers.buildOptimism(0xab22988D93d5F942fC6B6c6Ea285744809D1d9Cc);
    payloads[2] = GovHelpers.buildArbitrum(0xd0F0BC55Ac46f63A68F7c27fbFD60792C9571feA);
    payloads[3] = GovHelpers.buildPolygon(0xc7751400F809cdB0C167F87985083C558a0610F7);
    payloads[4] = GovHelpers.buildMetis(0xA9F30e6ED4098e9439B2ac8aEA2d3fc26BcEbb45);
    payloads[5] = GovHelpers.buildBase(0x80a2F9a653d3990878cFf8206588fd66699E7f2a);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231023_AaveV3_Multi_GovernanceV25Activation/GovernanceV25Activation.md'
      )
    );
  }
}
