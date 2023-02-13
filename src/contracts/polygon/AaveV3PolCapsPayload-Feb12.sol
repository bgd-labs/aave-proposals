// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets borrow caps for multiple assets on AAVE V3 Polygon
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-and-arbitrum-2023-02-07/11605
 */
contract AaveV3PolCapsPayload is IProposalGenericExecutor {
  address public constant BAL = AaveV3PolygonAssets.BAL_UNDERLYING;
  address public constant EURS = AaveV3PolygonAssets.EURS_UNDERLYING;
  address public constant DAI = AaveV3PolygonAssets.DAI_UNDERLYING;
  address public constant USDC = AaveV3PolygonAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3PolygonAssets.USDT_UNDERLYING;

  uint256 public constant BAL_SUPPLY_CAP = 361_000;

  uint256 public constant EURS_BORROW_CAP = 947_000;

  uint256 public constant DAI_BORROW_CAP = 30_000_000;
  uint256 public constant DAI_SUPPLY_CAP = 45_000_000;

  uint256 public constant USDC_BORROW_CAP = 100_000_000;
  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;

  uint256 public constant USDT_BORROW_CAP = 30_000_000;
  uint256 public constant USDT_SUPPLY_CAP = 45_000_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setSupplyCap(BAL, BAL_SUPPLY_CAP);

    configurator.setBorrowCap(EURS, EURS_BORROW_CAP);

    configurator.setBorrowCap(DAI, DAI_BORROW_CAP);
    configurator.setSupplyCap(DAI, DAI_SUPPLY_CAP);

    configurator.setBorrowCap(USDC, USDC_BORROW_CAP);
    configurator.setSupplyCap(USDC, USDC_SUPPLY_CAP);

    configurator.setBorrowCap(USDT, USDT_BORROW_CAP);
    configurator.setSupplyCap(USDT, USDT_SUPPLY_CAP);
  }
}
