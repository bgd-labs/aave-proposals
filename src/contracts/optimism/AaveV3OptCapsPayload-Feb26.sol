// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets borrow caps for multiple assets on AAVE V3 Optimism
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-2023-02-24/12048
 */
contract AaveV3OptCapsPayload is IProposalGenericExecutor {
  address public constant DAI = AaveV3OptimismAssets.DAI_UNDERLYING;
  address public constant SUSD = AaveV3OptimismAssets.sUSD_UNDERLYING;
  address public constant USDC = AaveV3OptimismAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3OptimismAssets.USDT_UNDERLYING;
  address public constant AAVE = AaveV3OptimismAssets.AAVE_UNDERLYING;
  address public constant LINK = AaveV3OptimismAssets.LINK_UNDERLYING;
  address public constant WBTC = AaveV3OptimismAssets.WBTC_UNDERLYING;

  uint256 public constant DAI_SUPPLY_CAP = 25_000_000;
  uint256 public constant DAI_BORROW_CAP = 16_000_000;
  
  uint256 public constant SUSD_BORROW_CAP = 13_000_000;

  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;

  uint256 public constant USDT_SUPPLY_CAP = 25_000_000;
  uint256 public constant USDT_BORROW_CAP = 16_000_000;

  uint256 public constant AAVE_SUPPLY_CAP = 45_000;

  uint256 public constant LINK_SUPPLY_CAP = 160_000;
  uint256 public constant LINK_BORROW_CAP = 84_000;

  uint256 public constant WBTC_SUPPLY_CAP = 620;
  uint256 public constant WBTC_BORROW_CAP = 250;

  function execute() external {

    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(DAI, DAI_SUPPLY_CAP);
    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(DAI, DAI_BORROW_CAP);

    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(SUSD, SUSD_BORROW_CAP);

    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(USDC, USDC_SUPPLY_CAP);
    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(USDC, USDC_BORROW_CAP);
    
    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(USDT, USDT_SUPPLY_CAP);
    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(USDT, USDT_BORROW_CAP);

    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(AAVE, AAVE_SUPPLY_CAP);

    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(LINK, LINK_SUPPLY_CAP);
    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(LINK, LINK_BORROW_CAP);

    AaveV3Optimism.POOL_CONFIGURATOR.setSupplyCap(WBTC, WBTC_SUPPLY_CAP);
    AaveV3Optimism.POOL_CONFIGURATOR.setBorrowCap(WBTC, WBTC_BORROW_CAP);

  }
}
