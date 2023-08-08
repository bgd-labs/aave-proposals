// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_ServiceProviders_20231907} from './AaveV2_Eth_ServiceProviders_20231907.sol';

/**
 * @dev Deploy AaveV2_Eth_ServiceProviders_20231907
 * command: make deploy-ledger contract=src/AaveV2_Eth_ServiceProviders_20231907/AaveV2_Eth_ServiceProviders_20231907.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereumPayload is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_ServiceProviders_20231907();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2_Eth_ServiceProviders_20231907/AaveV2_Eth_ServiceProviders_20231907.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposalEthServiceProviders is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x7A2Fa9c7BeB9f8518373f0F63E3Cc75b5B4Dd3c7);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV2_Eth_ServiceProviders_20231907/ServiceProviders.md')
    );
  }
}
