// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets borrow caps for multiple assets on AAVE V3 Arbitrum
 * - Snapshot: TBD //TODO
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-2023-02-24/12048
 */
contract AaveV3ArbCapsPayload is IProposalGenericExecutor {
  address public constant DAI = AaveV3ArbitrumAssets.DAI_UNDERLYING;
  address public constant EURS = AaveV3ArbitrumAssets.EURS_UNDERLYING;
  address public constant USDC = AaveV3ArbitrumAssets.USDC_UNDERLYING;
  address public constant USDT = AaveV3ArbitrumAssets.USDT_UNDERLYING;
  address public constant AAVE = AaveV3ArbitrumAssets.AAVE_UNDERLYING;

  uint256 public constant DAI_SUPPLY_CAP = 50_000_000;
  uint256 public constant DAI_BORROW_CAP = 30_000_000;

  uint256 public constant EURS_SUPPLY_CAP = 60_000;
  uint256 public constant EURS_BORROW_CAP = 45_000;

  uint256 public constant USDC_SUPPLY_CAP = 150_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;

  uint256 public constant USDT_SUPPLY_CAP = 50_000_000;
  uint256 public constant USDT_BORROW_CAP = 35_000_000;

  uint256 public constant AAVE_SUPPLY_CAP = 1_850;

  function execute() external {
    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(DAI, DAI_SUPPLY_CAP);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setBorrowCap(DAI, DAI_BORROW_CAP);

    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(EURS, EURS_SUPPLY_CAP);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setBorrowCap(EURS, EURS_BORROW_CAP);

    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(USDC, USDC_SUPPLY_CAP);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setBorrowCap(USDC, USDC_BORROW_CAP);

    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(USDT, USDT_SUPPLY_CAP);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setBorrowCap(USDT, USDT_BORROW_CAP);

    AaveV3Arbitrum.POOL_CONFIGURATOR.setSupplyCap(AAVE, AAVE_SUPPLY_CAP);

  }
}
