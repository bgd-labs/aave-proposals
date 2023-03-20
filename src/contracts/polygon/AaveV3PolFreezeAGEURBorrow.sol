// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev Aave governance payload to disable borrow of agEUR asset on Aave v3 Polygon
 * - Snapshot: N/A Urgent proposal
 * - Dicussion: https://governance.aave.com/t/arfc-disable-borrow-of-ageur-on-aave-v3-polygon/12275
 */
contract AaveV3PolFreezeAGEURBorrow is IProposalGenericExecutor {
  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setReserveBorrowing(AaveV3PolygonAssets.agEUR_UNDERLYING, false);
  }
}
