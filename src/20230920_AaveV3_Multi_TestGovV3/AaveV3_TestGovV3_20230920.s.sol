// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Ethereum_TestGovV3_20230920} from './AaveV3_Ethereum_TestGovV3_20230920.sol';
import {AaveV3_Optimism_TestGovV3_20230920} from './AaveV3_Optimism_TestGovV3_20230920.sol';

/**
 * @dev Deploy AaveV3_Ethereum_TestGovV3_20230920
 * command: make deploy-ledger contract=src/20230920_AaveV3_Multi_TestGovV3/AaveV3_TestGovV3_20230920.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    AaveV3_Ethereum_TestGovV3_20230920 payload = new AaveV3_Ethereum_TestGovV3_20230920();
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(address(payload)));
  }
}

/**
 * @dev Deploy AaveV3_Optimism_TestGovV3_20230920
 * command: make deploy-ledger contract=src/20230920_AaveV3_Multi_TestGovV3/AaveV3_TestGovV3_20230920.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    AaveV3_Optimism_TestGovV3_20230920 payload = new AaveV3_Optimism_TestGovV3_20230920();
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(address(payload)));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230920_AaveV3_Multi_TestGovV3/AaveV3_TestGovV3_20230920.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);
    payloads[0] = GovV3Helpers.buildMainnet(vm, GovV3Helpers.buildAction(address(0)));

    payloads[1] = GovV3Helpers.buildOptimism(vm, GovV3Helpers.buildAction(address(0)));

    GovV3Helpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230920_AaveV3_Multi_TestGovV3/TestGovV3.md')
    );
  }
}
