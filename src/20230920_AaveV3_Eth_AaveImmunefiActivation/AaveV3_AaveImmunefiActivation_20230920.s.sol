// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_AaveImmunefiActivation_20230920} from './AaveV3_Ethereum_AaveImmunefiActivation_20230920.sol';

/**
 * @dev Deploy AaveV3_Ethereum_AaveImmunefiActivation_20230920
 * command: make deploy-ledger contract=src/20230920_AaveV3_Eth_AaveImmunefiActivation/AaveV3_AaveImmunefiActivation_20230920.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AaveImmunefiActivation_20230920();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230920_AaveV3_Eth_AaveImmunefiActivation/AaveV3_AaveImmunefiActivation_20230920.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0xe89e12217B2c602C234da8F85D76bf4C98026B81);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230920_AaveV3_Eth_AaveImmunefiActivation/AaveImmunefiActivation.md'
      )
    );
  }
}
