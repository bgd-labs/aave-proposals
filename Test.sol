// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_Test_20230926} from './AaveV2Ethereum_Test_20230926.sol';
import {AaveV2EthereumAMM_Test_20230926} from './AaveV2EthereumAMM_Test_20230926.sol';

/**
    * @dev Deploy Ethereum
    * command: make deploy-ledger contract=src/20230926_Multi_Test/Test_20230926.s.sol:DeployEthereum chain=mainnet
    */
   contract DeployEthereum is EthereumScript {
     function run() external broadcast {
       // deploy payloads
       AaveV2Ethereum_Test_20230926 payload0 = new AaveV2Ethereum_Test_20230926();,AaveV2EthereumAMM_Test_20230926 payload1 = new AaveV2EthereumAMM_Test_20230926();

       // compose action
       IPayloadsControllerCore.ExecutionAction[] memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
       actions[0] = GovV3Helpers.buildAction(address(payload0));,actions[1] = GovV3Helpers.buildAction(address(payload1));

       // register action at payloadsController
       GovV3Helpers.createPayload(actions);
     }
   }

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230926_Multi_Test/Test_20230926.s.sol:CreateProposal chain=mainnet
 */
// contract CreateProposal is EthereumScript {
//   function run() external broadcast {
//     // create payloads
//     PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

//     // compose actions for validation
//     IPayloadsControllerCore.ExecutionAction[] memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
// actionsEthereum[0] = GovV3Helpers.buildAction(address(0));
// actionsEthereum[1] = GovV3Helpers.buildAction(address(0));payloads[0] = GovV3Helpers.buildMainnet(vm, actionsEthereum);


//     // create proposal
//     GovV3Helpers.createProposal(payloads, GovHelpers.ipfsHashFile(vm, 'src/20230926_Multi_Test/Test.md'));
//   }
// }