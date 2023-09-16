// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_AaveBGDPhase2_20230828} from './AaveV3_Ethereum_AaveBGDPhase2_20230828.sol';

/**
 * @dev Deploy AaveV3_Ethereum_AaveBGDPhase2_20230828
 * command: make deploy-ledger contract=src/20230828_AaveV3_Eth_AaveBGDPhase2/AaveV3_AaveBGDPhase2_20230828.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_AaveBGDPhase2_20230828();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230828_AaveV3_Eth_AaveBGDPhase2/AaveV3_AaveBGDPhase2_20230828.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0)); // TODO
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230828_AaveV3_Eth_AaveBGDPhase2/AaveBGDPhase2.md')
    );
  }
}
