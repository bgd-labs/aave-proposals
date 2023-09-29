// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

/**
 * @title Add DebtSwapAdapter as FlashBorrower
 * @author BGD labs
 * - Discussion: https://governance.aave.com/t/bgd-grant-flashborrower-role-to-debtswapadapter-s/14595
 */
contract AaveV3_Optimism_AddDebtSwapAdapterAsFlashBorrower_20230809 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = AaveV3Optimism.DEBT_SWAP_ADAPTER;

  function execute() external {
    AaveV3Optimism.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
