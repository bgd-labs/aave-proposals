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
 * command: make deploy-ledger contract=src/AaveV2EthBUSDIR_20230804/DeployBUSDOffBoard.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(0x40c3aECDEDa52375eACccD4F89420FFaa1607e3c);
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AaveV2EthBUSDIR_20230804/BUSD-OFFBOARDING-PLAN-PART-III-AIP.md'
      )
    );
  }
}
