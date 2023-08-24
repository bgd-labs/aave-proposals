// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Add DebtSwapAdapter as FlashBorrower
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = 0xcFaE0D8c5707FCc6478D6a65fFA31efADeF8b8EC;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
