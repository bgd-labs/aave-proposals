// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

/**
 * @title Add DebtSwapAdapter as FlashBorrower
 * @author BGD labs
 * - Discussion: https://governance.aave.com/t/bgd-grant-flashborrower-role-to-debtswapadapter-s/14595
 */
contract AaveV3_Arbitrum_AddDebtSwapAdapterAsFlashBorrower_20230809 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = AaveV3Arbitrum.DEBT_SWAP_ADAPTER;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
