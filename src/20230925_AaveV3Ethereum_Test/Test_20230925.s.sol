// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_Test_20230925} from './AaveV3Ethereum_Test_20230925.sol';

/**
 * @dev Deploy AaveV3Ethereum_Test_20230925
 * command: make deploy-ledger contract=src/20230925_AaveV3Ethereum_Test/Test_20230925.s.sol:DeployAaveV3Ethereum chain=mainnet
 */
contract DeployAaveV3Ethereum is EthereumScript {
  function run() external broadcast {
    AaveV3Ethereum_Test_20230925 payload = new AaveV3Ethereum_Test_20230925();
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(address(payload)));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230925_AaveV3Ethereum_Test/Test_20230925.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);
    payloads[0] = GovV3Helpers.buildMainnet(vm, GovV3Helpers.buildAction(address(0)));

    GovV3Helpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(vm, 'src/20230925_AaveV3Ethereum_Test/Test.md')
    );
  }
}
