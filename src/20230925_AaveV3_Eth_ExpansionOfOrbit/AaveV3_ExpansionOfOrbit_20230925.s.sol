// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_ExpansionOfOrbit_20230925} from './AaveV3_Ethereum_ExpansionOfOrbit_20230925.sol';

/**
 * @dev Deploy AaveV3_Ethereum_ExpansionOfOrbit_20230925
 * command: make deploy-ledger contract=src/20230925_AaveV3_Eth_ExpansionOfOrbit/AaveV3_ExpansionOfOrbit_20230925.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_ExpansionOfOrbit_20230925();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230925_AaveV3_Eth_ExpansionOfOrbit/AaveV3_ExpansionOfOrbit_20230925.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x390000ED3D6289FbfEB1Af663A9812A1001573B7);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230925_AaveV3_Eth_ExpansionOfOrbit/ExpansionOfOrbit.md')
    );
  }
}
