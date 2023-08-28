// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Add DebtSwapAdapter as FlashBorrower
 * @author BGD labs
 * - Discussion: https://governance.aave.com/t/bgd-grant-flashborrower-role-to-debtswapadapter-s/14595
 */
contract AaveV3_Polygon_AddDebtSwapAdapterAsFlashBorrower_20230809 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = 0xb58Fd91558fa213D97Ac94C97F831c7289278084;

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
