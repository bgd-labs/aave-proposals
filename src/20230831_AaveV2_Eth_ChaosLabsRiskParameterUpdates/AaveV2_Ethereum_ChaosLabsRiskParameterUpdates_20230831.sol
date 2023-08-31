// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Chaos Labs Risk Parameter Updates
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0xc5786999ac6d574ca2fb3a3f169be0c38221d73613d4458afa87ab0251f4418a
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v2-ethereum-2023-08-09/14404
 */
contract AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831 is IProposalGenericExecutor {
  function execute() external {
    // BAL
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.BAL_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.BAL_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 35_00,
      liquidationBonus: 108_00
    });

    // BAT
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.BAT_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.BAT_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 40_00,
      liquidationBonus: 110_00
    });

    // CVX
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.CVX_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.CVX_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 35_00,
      liquidationBonus: 108_50
    });

    // DPI
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.DPI_UNDERLYING, 35_00);

    // ENJ
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ENJ_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.ENJ_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 52_00,
      liquidationBonus: 110_00
    });

    // MANA
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.MANA_UNDERLYING, 50_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.MANA_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 54_00,
      liquidationBonus: 110_00
    });

    // REN
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.REN_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.REN_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 32_00,
      liquidationBonus: 110_00
    });

    // xSUSHI
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      50_00
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 57_00,
      liquidationBonus: 110_00
    });

    // YFI
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.YFI_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.YFI_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 50_00,
      liquidationBonus: 110_00
    });

    // ZRX
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ZRX_UNDERLYING, 35_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.ZRX_UNDERLYING,
      ltv: 0,
      liquidationThreshold: 42_00,
      liquidationBonus: 110_00
    });

    // LINK
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LINK_UNDERLYING, 30_00);

    // 1INCH
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      30_00
    );
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      ltv: 30_00,
      liquidationThreshold: 40_00,
      liquidationBonus: 108_50
    });

    // UNI
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.UNI_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.UNI_UNDERLYING,
      ltv: 58_00,
      liquidationThreshold: 70_00,
      liquidationBonus: 109_00
    });

    // SNX
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.SNX_UNDERLYING, 45_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.SNX_UNDERLYING,
      ltv: 36_00,
      liquidationThreshold: 49_00,
      liquidationBonus: 107_50
    });

    // MKR
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.MKR_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.MKR_UNDERLYING,
      ltv: 45_00,
      liquidationThreshold: 50_00,
      liquidationBonus: 107_50
    });

    // ENS
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ENS_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral({
      asset: AaveV2EthereumAssets.ENS_UNDERLYING,
      ltv: 42_00,
      liquidationThreshold: 52_00,
      liquidationBonus: 108_00
    });

    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.FRAX_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.GUSD_UNDERLYING, 20_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LUSD_UNDERLYING, 20_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.sUSD_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDC_UNDERLYING, 20_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDP_UNDERLYING, 20_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDT_UNDERLYING, 20_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.CRV_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WBTC_UNDERLYING, 30_00);
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WETH_UNDERLYING, 25_00);
  }
}
