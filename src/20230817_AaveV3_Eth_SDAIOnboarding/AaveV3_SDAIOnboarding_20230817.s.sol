// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_SDAIOnboarding_20230817} from './AaveV3_Ethereum_SDAIOnboarding_20230817.sol';
import {AaveV2_Ethereum_DAIParamsUpdates_20230817} from 'src/20230817_AaveV3_Eth_SDAIOnboarding/AaveV2_Ethereum_DAIParamsUpdates_20230817.sol';

/**
 * @dev Deploy AaveV3_Ethereum_SDAIOnboarding_20230817
 * command: make deploy-ledger contract=src/20230817_AaveV3_Eth_SDAIOnboarding/AaveV3_SDAIOnboarding_20230817.s.sol:DeployEthereumV3 chain=mainnet
 */
contract DeployEthereumV3 is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_SDAIOnboarding_20230817();
  }
}

/**
 * @dev Deploy AaveV2_Ethereum_DAIParamsUpdates_20230817
 * command: make deploy-ledger contract=src/20230817_AaveV3_Eth_SDAIOnboarding/AaveV3_SDAIOnboarding_20230817.s.sol:DeployEthereumV2 chain=mainnet
 */
contract DeployEthereumV2 is EthereumScript {
  function run() external broadcast {
    new AaveV2_Ethereum_DAIParamsUpdates_20230817();
  }
}


/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230817_AaveV3_Eth_SDAIOnboarding/AaveV3_SDAIOnboarding_20230817.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(0x5bFB45198eD029443f0d41cA6Ed70789DdD9fD01);
    payloads[1] = GovHelpers.buildMainnet(0xF2A9129773542686ffa009F29F3AA02ae1c0Edf7);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230817_AaveV3_Eth_SDAIOnboarding/SDAIOnboarding.md')
    );
  }
}
