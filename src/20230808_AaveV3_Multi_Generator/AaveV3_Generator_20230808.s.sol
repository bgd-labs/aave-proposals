// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_Generator_20230808} from './AaveV3_Ethereum_Generator_20230808.sol';
import {AaveV3_Optimism_Generator_20230808} from './AaveV3_Optimism_Generator_20230808.sol';

/**
 * @dev Deploy AaveV3_Ethereum_Generator_20230808
 * command: make deploy-ledger contract=src/20230808_AaveV3_Multi_Generator/20230808_AaveV3_Multi_Generator.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3_Ethereum_Generator_20230808();
  }
}

/**
 * @dev Deploy AaveV3_Optimism_Generator_20230808
 * command: make deploy-ledger contract=src/20230808_AaveV3_Multi_Generator/20230808_AaveV3_Multi_Generator.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_Generator_20230808();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230808_AaveV3_Multi_Generator/20230808_AaveV3_Multi_Generator.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](2);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    payloads[1] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230808_AaveV3_Multi_Generator/Generator.md'));
  }
}