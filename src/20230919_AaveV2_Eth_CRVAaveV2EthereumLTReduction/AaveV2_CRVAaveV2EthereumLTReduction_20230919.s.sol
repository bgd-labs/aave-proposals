// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919} from './AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919.sol';

/**
 * @dev Deploy AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919
 * command: make deploy-ledger contract=src/20230919_AaveV2_Eth_CRVAaveV2EthereumLTReduction/AaveV2_CRVAaveV2EthereumLTReduction_20230919.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Ethereum_CRVAaveV2EthereumLTReduction_20230919();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20230919_AaveV2_Eth_CRVAaveV2EthereumLTReduction/AaveV2_CRVAaveV2EthereumLTReduction_20230919.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0x77CD8AC33C5cCdaE345C223BCbD0e2d45cb430aF));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20230919_AaveV2_Eth_CRVAaveV2EthereumLTReduction/CRVAaveV2EthereumLTReduction.md'
      )
    );
  }
}
