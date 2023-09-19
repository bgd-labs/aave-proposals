// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_GovV3Test_20230919} from './AaveV3_Ethereum_GovV3Test_20230919.sol';
import {AaveV3_Optimism_GovV3Test_20230919} from './AaveV3_Optimism_GovV3Test_20230919.sol';
import {AaveV3_Arbitrum_GovV3Test_20230919} from './AaveV3_Arbitrum_GovV3Test_20230919.sol';

/**
 * @dev Deploy AaveV3_Ethereum_GovV3Test_20230919
 * command: make deploy-ledger contract=src/20230919_AaveV3_Multi_GovV3Test/AaveV3_GovV3Test_20230919.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    AaveV3_Ethereum_GovV3Test_20230919 payload = new AaveV3_Ethereum_GovV3Test_20230919();
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload));
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy AaveV3_Optimism_GovV3Test_20230919
 * command: make deploy-ledger contract=src/20230919_AaveV3_Multi_GovV3Test/AaveV3_GovV3Test_20230919.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    AaveV3_Optimism_GovV3Test_20230919 payload = new AaveV3_Optimism_GovV3Test_20230919();
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload));
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy AaveV3_Arbitrum_GovV3Test_20230919
 * command: make deploy-ledger contract=src/20230919_AaveV3_Multi_GovV3Test/AaveV3_GovV3Test_20230919.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    AaveV3_Arbitrum_GovV3Test_20230919 payload = new AaveV3_Arbitrum_GovV3Test_20230919();
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload));
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230919_AaveV3_Multi_GovV3Test/AaveV3_GovV3Test_20230919.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    GovV3Helpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230919_AaveV3_Multi_GovV3Test/GovV3Test.md')
    );
  }
}
