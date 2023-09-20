// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Aave <> Immunefi activation
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb477feee6d506be940154bc84278654f2863044854f80fca825b236253a97778
 * - Discussion: https://governance.aave.com/t/bgd-aave-immunefi-bug-bounty-program/14757
 */
contract AaveV3_Ethereum_AaveImmunefiActivation_20230920 is IProposalGenericExecutor {
  event Decision(string agreed);

  function execute() external {
    // This proposal only serves as binding approval from the Aave DAO to authorize the activation
    // of the Aave <> Immunefi bug bounty program, with no side effect apart from the emitted event
    emit Decision(
      'The Aave DAO authorises the activation of an Aave <> Immunefi bug bounty program'
    );
  }
}
