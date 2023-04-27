// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Arbitrum, IACLManager} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal add DeFi Saver as a flash borrower on Aave V3 Arbitrum
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcebb97fa8e551a79e7aae28a135ec0fd26fcb88e8262375f4b4e81ef7047e665
 * - Discussion: https://governance.aave.com/t/arfc-add-defi-saver-to-flashborrowers-on-aave-v3/12410
 */

contract AaveV3ARBDFSFlashBorrowActivation is IProposalGenericExecutor {
  address public constant FL_AAVE_V3 = 0x219ac6dA971dE6d943cffD1BD62abde71525d382;
  address public constant FL_ACTION = 0x1561EAF39c98d45C55C7dC605E627672F4406819;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(FL_AAVE_V3);
    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(FL_ACTION);
  }
}
