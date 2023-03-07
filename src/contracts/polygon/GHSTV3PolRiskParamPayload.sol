// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal change GHST risk parameters on Aave V3 Polygon
 * @author @marczeller - Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP process
 * - Discussion: https://governance.aave.com/t/arfc-ghst-polygon-v3-soft-freeze/12192
 */

contract GHSTV3RiskParamPayload is IProposalGenericExecutor {
  address public constant GHST = AaveV3PolygonAssets.GHST_UNDERLYING;
  uint256 public constant GHST_SUPPLY_CAP = 4_650_000;
  uint256 public constant GHST_BORROW_CAP = 220_000;
  uint256 public constant GHST_LTV = 0;
  uint256 public constant GHST_LIQ_THRESHOLD = 4500;
  uint256 public constant GHST_LIQ_BONUS = 11500;
  bool public constant GHST_BORROWING_ENABLED = false;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(GHST, GHST_SUPPLY_CAP);
    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(GHST, GHST_BORROW_CAP);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveBorrowing(GHST, GHST_BORROWING_ENABLED);
    AaveV3Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: GHST,
      ltv: GHST_LTV,
      liquidationThreshold: GHST_LIQ_THRESHOLD,
      liquidationBonus: GHST_LIQ_BONUS
    });
  }
}
