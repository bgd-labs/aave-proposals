// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_VGHOImprovement_20230826} from './AaveV3_Ethereum_VGHOImprovement_20230826.sol';

/**
 * @dev Deploy AaveV3_Ethereum_VGHOImprovement_20230826
 * command: make deploy-ledger contract=src/20230826_AaveV3_Eth_VGHOImprovement/AaveV3_VGHOImprovement_20230826.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  address constant NEW_VGHO_IMPL = 0x7aa606b1B341fFEeAfAdbbE4A2992EFB35972775;

  function run() external broadcast {
    new AaveV3_Ethereum_VGHOImprovement_20230826(NEW_VGHO_IMPL);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230826_AaveV3_Eth_VGHOImprovement/AaveV3_VGHOImprovement_20230826.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x8799296F766E7B2F6d95939a641e7aEd09b6224b);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230826_AaveV3_Eth_VGHOImprovement/VGHOImprovement.md')
    );
  }
}
