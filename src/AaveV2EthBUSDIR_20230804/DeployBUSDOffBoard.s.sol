// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthBUSDIR_20230804} from 'src/AaveV2EthBUSDIR_20230804/AaveV2EthBUSDIR_20230804.sol';

/**
 * @dev Deploy AaveV2EthBUSDIR_20230804
 * command: make deploy-ledger contract=src/AaveV2EthBUSDIR_20230804/AaveV2EthBUSDIR_20230804.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV2EthBUSDIR_20230804();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AaveV2EthBUSDIR_20230804/AaveV2EthBUSDIR_20230804.s.sol:CreateProposal chain=mainnet
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