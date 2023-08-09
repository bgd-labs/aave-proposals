// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_CRVLTUpdate_20230806} from './AaveV2_Eth_CRVLTUpdate_20230806.sol';

/**
 * @dev Deploy AaveV2_Eth_CRVLTUpdate_20230806
 * command: make deploy-pk contract=src/AaveV2_Eth_CRVLTUpdate_20230806/AaveV2_Eth_CRVLTUpdate_20230806.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_CRVLTUpdate_20230806();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-pk  contract=src/AaveV2_Eth_CRVLTUpdate_20230806/AaveV2_Eth_CRVLTUpdate_20230806.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0xaF07C70420f6471329B5A32f0fA77776Fba7147C));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/AaveV2_Eth_CRVLTUpdate_20230806/CRVLTUpdate.md'));
  }
}