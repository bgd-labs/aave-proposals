// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets supply caps for multiple assets on AAVE V3 Polygon
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-2023-02-24/12048
 * - Discussion stMatic: https://governance.aave.com/t/arfc-increase-stmatic-supply-cap/12038
 */
contract AaveV3PolCapsPayload is IProposalGenericExecutor {
  address public constant WETH = AaveV3PolygonAssets.WETH_UNDERLYING;
  address public constant AAVE = AaveV3PolygonAssets.AAVE_UNDERLYING;
  address public constant STMATIC = AaveV3PolygonAssets.stMATIC_UNDERLYING;

  uint256 public constant WETH_SUPPLY_CAP = 50_000;
  uint256 public constant AAVE_SUPPLY_CAP = 70_000;
  uint256 public constant STMATIC_SUPPLY_CAP = 15_000_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setSupplyCap(WETH, WETH_SUPPLY_CAP);
    configurator.setSupplyCap(AAVE, AAVE_SUPPLY_CAP);
    configurator.setSupplyCap(STMATIC, STMATIC_SUPPLY_CAP);
  }
}
