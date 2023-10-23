// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_EventsAip_20231010} from './AaveV3_Ethereum_EventsAip_20231010.sol';

/**
 * @dev Deploy AaveV3_Ethereum_EventsAip_20231010
 * command: make deploy-ledger contract=src/20231010_AaveV3_Eth_EventsAip/AaveV3_EventsAip_20231010.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_EventsAip_20231010();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231010_AaveV3_Eth_EventsAip/AaveV3_EventsAip_20231010.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xfa9aF30481942a31E6AE47f199C6c2a3978b5c33);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20231010_AaveV3_Eth_EventsAip/EventsAip.md')
    );
  }
}
