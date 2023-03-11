// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

contract USDCDepegRiskProtection {
  function execute() external {
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(AaveV3AvalancheAssets.USDC_UNDERLYING, true);
    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.USDC_UNDERLYING,
      0,
      86_25,
      10400
    );

    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(AaveV3AvalancheAssets.DAIe_UNDERLYING, true);
    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.DAIe_UNDERLYING,
      0,
      82_00,
      10500
    );

    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(AaveV3AvalancheAssets.FRAX_UNDERLYING, true);
    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.FRAX_UNDERLYING,
      0,
      80_00,
      10500
    );

    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(AaveV3AvalancheAssets.MAI_UNDERLYING, true);
    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.MAI_UNDERLYING,
      0,
      80_00,
      10500
    );

    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(AaveV3AvalancheAssets.USDt_UNDERLYING, true);
    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.USDt_UNDERLYING,
      0,
      81_00,
      10500
    );
  }
}
