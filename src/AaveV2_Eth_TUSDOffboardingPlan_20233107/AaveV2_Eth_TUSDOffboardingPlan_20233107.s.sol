// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2_Eth_TUSDOffboardingPlan_20233107} from './AaveV2_Eth_TUSDOffboardingPlan_20233107.sol';

/**
 * @dev Deploy AaveV2_Eth_TUSDOffboardingPlan_20233107
 * command: make deploy-ledger contract=src/AaveV2_Eth_TUSDOffboardingPlan_20233107/AaveV2_Eth_TUSDOffboardingPlan_20233107.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2_Eth_TUSDOffboardingPlan_20233107();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2_Eth_TUSDOffboardingPlan_20233107/AaveV2_Eth_TUSDOffboardingPlan_20233107.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2_Eth_TUSDOffboardingPlan_20233107/TUSDOffboardingPlan.md'
      )
    );
  }
}
