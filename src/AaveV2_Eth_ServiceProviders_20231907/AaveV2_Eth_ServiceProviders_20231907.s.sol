// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_ServiceProviders_20231907} from './AaveV2_Eth_ServiceProviders_20231907.sol';

/**
 * @dev Deploy AaveV3_Eth_ServiceProviders_20231907
 * command: make deploy-ledger contract=src/AaveV3_Eth_ServiceProviders_20231907/AaveV3_Eth_ServiceProviders_20231907.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_ServiceProviders_20231907();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV3_Eth_ServiceProviders_20231907/AaveV3_Eth_ServiceProviders_20231907.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/AaveV3_Eth_ServiceProviders_20231907/ServiceProviders.md')
    );
  }
}
