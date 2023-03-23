// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This payload sets supply/borrow caps for stMATIC and MAI assets on AAVE V3 Polygon
 * @author @yonikesel - ChaosLabs
 * - Snapshot: Direct-to-AIP ARFC framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-2023-03-16/12310
 */
contract AaveV3PolCapsPayload is IProposalGenericExecutor {
  uint256 public constant MAI_SUPPLY_CAP = 2_200_000;
  uint256 public constant MAI_BORROW_CAP = 1_200_000;
  uint256 public constant STMATIC_SUPPLY_CAP = 21_000_000;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.miMATIC_UNDERLYING,
      MAI_SUPPLY_CAP
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(
      AaveV3PolygonAssets.miMATIC_UNDERLYING,
      MAI_BORROW_CAP
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.stMATIC_UNDERLYING,
      STMATIC_SUPPLY_CAP
    );
  }
}
