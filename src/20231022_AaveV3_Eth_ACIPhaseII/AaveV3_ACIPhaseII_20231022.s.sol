// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_ACIPhaseII_20231022} from './AaveV3_Ethereum_ACIPhaseII_20231022.sol';

/**
 * @dev Deploy AaveV3_Ethereum_ACIPhaseII_20231022
 * command: make deploy-ledger contract=src/20231022_AaveV3_Eth_ACIPhaseII/AaveV3_ACIPhaseII_20231022.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_ACIPhaseII_20231022();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231022_AaveV3_Eth_ACIPhaseII/AaveV3_ACIPhaseII_20231022.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x37764148819A1C72CBEbeEc841229Dc441b2644b);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20231022_AaveV3_Eth_ACIPhaseII/ACIPhaseII.md')
    );
  }
}
