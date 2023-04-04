// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Ethereum, IACLManager} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal add DeFi Saver as a flash borrower on Aave V3 Ethereum
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcebb97fa8e551a79e7aae28a135ec0fd26fcb88e8262375f4b4e81ef7047e665
 * - Discussion: https://governance.aave.com/t/arfc-add-defi-saver-to-flashborrowers-on-aave-v3/12410
 */

contract AaveV3EthDFSFlashBorrowActivation is IProposalGenericExecutor {
  address public constant FL_AAVE_V3 = 0xd9D8e68717Ce24CCbf162868aaad7E38d81b05d1;
  address public constant FL_ACTION = 0x72915D41982DfCAf30b871290618E59C45Edba7F;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(FL_AAVE_V3);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(FL_ACTION);
  }
}
