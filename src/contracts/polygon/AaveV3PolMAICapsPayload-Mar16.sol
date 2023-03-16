// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title This proposal change MAI supply & borrow caps on Aave V3 Polygon
 * @author @yonikesel - ChaosLabs
 * - Snapshot: Direct-to-AIP ARFC framework
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-2023-03-16/12310
 */

contract AaveV3PolMAICapsPayload is IProposalGenericExecutor {
  uint256 public constant MAI_SUPPLY_CAP = 2_200_000;
  uint256 public constant MAI_BORROW_CAP = 1_200_000;

  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setSupplyCap(
      AaveV3PolygonAssets.miMATIC_UNDERLYING,
      MAI_SUPPLY_CAP
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setBorrowCap(
      AaveV3PolygonAssets.miMATIC_UNDERLYING,
      MAI_BORROW_CAP
    );
  }
}
