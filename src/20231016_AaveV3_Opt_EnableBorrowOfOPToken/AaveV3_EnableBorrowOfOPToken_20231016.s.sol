// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3_Optimism_EnableBorrowOfOPToken_20231016} from './AaveV3_Optimism_EnableBorrowOfOPToken_20231016.sol';

/**
 * @dev Deploy AaveV3_Optimism_EnableBorrowOfOPToken_20231016
 * command: make deploy-ledger contract=src/20231016_AaveV3_Opt_EnableBorrowOfOPToken/AaveV3_EnableBorrowOfOPToken_20231016.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    new AaveV3_Optimism_EnableBorrowOfOPToken_20231016();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231016_AaveV3_Opt_EnableBorrowOfOPToken/AaveV3_EnableBorrowOfOPToken_20231016.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildOptimism(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/20231016_AaveV3_Opt_EnableBorrowOfOPToken/EnableBorrowOfOPToken.md'
      )
    );
  }
}
