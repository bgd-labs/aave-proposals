// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';


/**
 * @title Add DebtSwapAdapter as FlashBorrower
 * @author BGD labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3_Avalanche_AddDebtSwapAdapterAsFlashBorrower_20230809 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = address(0);

  function execute() external {
  }

}