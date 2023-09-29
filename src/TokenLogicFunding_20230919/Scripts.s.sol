// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {TokenLogicFunding_20230919} from './TokenLogicFunding_20230919.sol';

/**
 * @dev Deploy TokenLogicFunding_20230919
 * command: make deploy-ledger contract=src/TokenLogicFunding_20230919/Scripts.s.sol:DeployPayload chain=mainnet
 */
contract DeployPayload is EthereumScript {
  function run() external broadcast {
    new TokenLogicFunding_20230919();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/TokenLogicFunding_20230919/Scripts.s.sol:ProposePayload chain=mainnet
 */
contract ProposePayload is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(
      0xE5Cac83F10F9eed3fe1575AEe87DE030815F1d83
    );
    GovHelpers.createProposal(
      payloads,
      GovHelpers.ipfsHashFile(
        vm,
        'src/TokenLogicFunding_20230919/TOKENLOGIC_FUNDING.md'
      )
    );
  }
}
