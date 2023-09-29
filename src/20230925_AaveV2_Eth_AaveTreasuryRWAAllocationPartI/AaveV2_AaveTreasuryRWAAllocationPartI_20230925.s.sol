// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925} from './AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925.sol';

/**
 * @dev Deploy AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925
 * command: make deploy-ledger contract=src/20230925_AaveV2_Eth_AaveTreasuryRWAAllocationPartI/AaveV2_AaveTreasuryRWAAllocationPartI_20230925.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Ethereum_AaveTreasuryRWAAllocationPartI_20230925();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230925_AaveV2_Eth_AaveTreasuryRWAAllocationPartI/AaveV2_AaveTreasuryRWAAllocationPartI_20230925.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xfD6933AEDC23FcbA8B52dE85D2abfe6C93EF6f75);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230925_AaveV2_Eth_AaveTreasuryRWAAllocationPartI/AaveTreasuryRWAAllocationPartI.md'
      )
    );
  }
}
