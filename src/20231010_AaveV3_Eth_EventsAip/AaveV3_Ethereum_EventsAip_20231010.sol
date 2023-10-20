// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave Events & Sponsorship Budget Proposal
 * @dev Transfer GHO to Aave Co receiver address.
 * @author AaveCo
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xdcb072d9782c5160d824ee37919c1be35024bd5aec579a86fdfc024f60213ca1
 * - Discussion: https://governance.aave.com/t/temp-check-aave-events-sponsorship-budget/14953
 */
contract AaveV3_Ethereum_EventsAip_20231010 is IProposalGenericExecutor {
  address public constant RECEIVER = 0x1c037b3C22240048807cC9d7111be5d455F640bd;

  uint256 public constant GHO_AMOUNT = 550_000e18;

  function execute() external {
    // transfers gho tokens to receiver
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.GHO_UNDERLYING, RECEIVER, GHO_AMOUNT);
  }
}
