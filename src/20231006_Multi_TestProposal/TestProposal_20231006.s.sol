// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_TestProposal_20231006} from './AaveV2Ethereum_TestProposal_20231006.sol';
import {AaveV3Ethereum_TestProposal_20231006} from './AaveV3Ethereum_TestProposal_20231006.sol';
import {AaveV3Avalanche_TestProposal_20231006} from './AaveV3Avalanche_TestProposal_20231006.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231006_Multi_TestProposal/TestProposal_20231006.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Ethereum_TestProposal_20231006 payload0 = new AaveV2Ethereum_TestProposal_20231006();
    AaveV3Ethereum_TestProposal_20231006 payload1 = new AaveV3Ethereum_TestProposal_20231006();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(address(payload0));
    actions[1] = GovV3Helpers.buildAction(address(payload1));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * command: make deploy-ledger contract=src/20231006_Multi_TestProposal/TestProposal_20231006.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Avalanche_TestProposal_20231006 payload0 = new AaveV3Avalanche_TestProposal_20231006();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231006_Multi_TestProposal/TestProposal_20231006.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
    actionsEthereum[0] = GovV3Helpers.buildAction(address(0));
    actionsEthereum[1] = GovV3Helpers.buildAction(address(0));
    payloads[0] = GovV3Helpers.buildMainnet(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(address(0));
    payloads[1] = GovV3Helpers.buildAvalanche(vm, actionsAvalanche);

    // create proposal
    GovV3Helpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20231006_Multi_TestProposal/TestProposal.md')
    );
  }
}
