// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AgdAllowanceModification_20230817} from './AgdAllowanceModification_20230817.sol';

/**
 * @dev Deploy AgdAllowanceModification_20230817
 * command: make deploy-ledger contract=src/AgdAllowanceModification_20230817/Scripts.s.sol:DeployPayload chain=ethereum
 */
contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new AgdAllowanceModification_20230817();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/AgdAllowanceModification_20230817/Scripts.s.sol:ProposePayload chain=mainnet
 */
contract ProposePayload is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      address(0) // TODO
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/AgdAllowanceModification_20230817/MODIFY_AGD_ALLOWANCE.md'
      )
    );
  }
}
