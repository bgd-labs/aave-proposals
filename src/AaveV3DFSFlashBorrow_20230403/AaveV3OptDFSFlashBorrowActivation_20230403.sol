// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Optimism, IACLManager} from 'aave-address-book/AaveV3Optimism.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal add DeFi Saver as a flash borrower on Aave V3 OptimismAaveV3Optimism
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xcebb97fa8e551a79e7aae28a135ec0fd26fcb88e8262375f4b4e81ef7047e665
 * - Discussion: https://governance.aave.com/t/arfc-add-defi-saver-to-flashborrowers-on-aave-v3/12410
 */

contract AaveV3OptDFSFlashBorrowActivation is IProposalGenericExecutor {
  address public constant FL_AAVE_V3 = 0xfbcF23D2BeF8A2C491cfa4dD409D8dF12d431c85;
  address public constant FL_ACTION = 0xE668197A175E7A2143222a028470c6ABBBD183F6;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(FL_AAVE_V3);
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(FL_ACTION);
  }
}
