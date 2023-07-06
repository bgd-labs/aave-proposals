// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';

/**
 * @title This proposal updates risk parameters on Aave V2 Ethereum
 * @author @yonikesel - ChaosLabsInc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2d7bf95ae2f77992afdc1d507d31ff71bff89022e579e3bb2d01b770b77c0d2b
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-6-23/13789
 */
contract AaveV2EthRiskParams_20230702 is AaveV2PayloadEthereum {
  uint256 public constant BAL_LTV = 0; // 65 -> 0
  uint256 public constant BAL_LIQUIDATION_THRESHOLD = 55_00; // 70 -> 55
  uint256 public constant BAL_LIQUIDATION_BONUS = 10800; // unchanged
  uint256 public constant BAL_RF = 30_00; // 20 -> 30

  uint256 public constant BAT_LTV = 0; // 65 -> 0
  uint256 public constant BAT_LIQUIDATION_THRESHOLD = 52_00; // 70 -> 52
  uint256 public constant BAT_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant BAT_RF = 30_00; // 20 -> 30

  uint256 public constant CVX_LTV = 0; // 35 -> 0
  uint256 public constant CVX_LIQUIDATION_THRESHOLD = 40_00; // 45 -> 40
  uint256 public constant CVX_LIQUIDATION_BONUS = 10850; // unchanged
  uint256 public constant CVX_RF = 30_00; // 20 -> 30

  uint256 public constant DPI_LTV = 0; // 65 -> 0
  uint256 public constant DPI_LIQUIDATION_THRESHOLD = 42_00; // 70 -> 42
  uint256 public constant DPI_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant DPI_RF = 30_00; // 20 -> 30

  uint256 public constant ENJ_LTV = 0; // 60 -> 0
  uint256 public constant ENJ_LIQUIDATION_THRESHOLD = 60_00; // 67 -> 60
  uint256 public constant ENJ_LIQUIDATION_BONUS = 11000; // 6 -> 10
  uint256 public constant ENJ_RF = 30_00; // 20 -> 30

  uint256 public constant KNC_LTV = 0; // 60 -> 0
  uint256 public constant KNC_LIQUIDATION_THRESHOLD = 1_00; // 70 -> 1
  uint256 public constant KNC_LIQUIDATION_BONUS = 11000; // unchanged
  uint256 public constant KNC_RF = 30_00; // 20 -> 30

  uint256 public constant MANA_LTV = 0; // 61.5 -> 0
  uint256 public constant MANA_LIQUIDATION_THRESHOLD = 62_00; // 75 -> 62
  uint256 public constant MANA_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant MANA_RF = 45_00; // 35 -> 45

  uint256 public constant REN_LTV = 0; // 55 -> 0
  uint256 public constant REN_LIQUIDATION_THRESHOLD = 40_00; // 60 -> 40
  uint256 public constant REN_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant REN_RF = 30_00; // 20 -> 30

  uint256 public constant xSUSHI_LTV = 0; // 50 -> 0
  uint256 public constant xSUSHI_LIQUIDATION_THRESHOLD = 60_00; // 65 -> 60
  uint256 public constant xSUSHI_LIQUIDATION_BONUS = 11000; // 8.5 -> 10
  uint256 public constant xSUSHI_RF = 45_00; // 35 -> 45

  uint256 public constant YFI_LTV = 0; // 50 -> 0
  uint256 public constant YFI_LIQUIDATION_THRESHOLD = 55_00; // 65 -> 55
  uint256 public constant YFI_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant YFI_RF = 30_00; // 20 -> 30

  uint256 public constant ZRX_LTV = 0; // 55 -> 0
  uint256 public constant ZRX_LIQUIDATION_THRESHOLD = 45_00; // 65 -> 45
  uint256 public constant ZRX_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant ZRX_RF = 30_00; // 20 -> 30

  function _postExecute() internal override {
    // BAL
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      BAL_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      BAL_LTV,
      BAL_LIQUIDATION_THRESHOLD,
      BAL_LIQUIDATION_BONUS
    );

    // BAT
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.BAT_UNDERLYING,
      BAT_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAT_UNDERLYING,
      BAT_LTV,
      BAT_LIQUIDATION_THRESHOLD,
      BAT_LIQUIDATION_BONUS
    );

    // CVX
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      CVX_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      CVX_LTV,
      CVX_LIQUIDATION_THRESHOLD,
      CVX_LIQUIDATION_BONUS
    );

    // DPI
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      DPI_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      DPI_LTV,
      DPI_LIQUIDATION_THRESHOLD,
      DPI_LIQUIDATION_BONUS
    );

    // ENJ
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      ENJ_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      ENJ_LTV,
      ENJ_LIQUIDATION_THRESHOLD,
      ENJ_LIQUIDATION_BONUS
    );

    // KNC
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.KNC_UNDERLYING,
      KNC_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.KNC_UNDERLYING,
      KNC_LTV,
      KNC_LIQUIDATION_THRESHOLD,
      KNC_LIQUIDATION_BONUS
    );

    // MANA
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      MANA_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      MANA_LTV,
      MANA_LIQUIDATION_THRESHOLD,
      MANA_LIQUIDATION_BONUS
    );

    // REN
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.REN_UNDERLYING,
      REN_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      REN_LTV,
      REN_LIQUIDATION_THRESHOLD,
      REN_LIQUIDATION_BONUS
    );

    // xSUSHI
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      xSUSHI_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      xSUSHI_LTV,
      xSUSHI_LIQUIDATION_THRESHOLD,
      xSUSHI_LIQUIDATION_BONUS
    );

    // YFI
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      YFI_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      YFI_LTV,
      YFI_LIQUIDATION_THRESHOLD,
      YFI_LIQUIDATION_BONUS
    );

    // ZRX
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      ZRX_RF
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      ZRX_LTV,
      ZRX_LIQUIDATION_THRESHOLD,
      ZRX_LIQUIDATION_BONUS
    );
  }
}
