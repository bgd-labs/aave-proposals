// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

contract USDCDepegRiskProtection {
  function execute() external {
    address[] memory allReserves = AaveV3Avalanche.POOL.getReservesList();

    for (uint256 i = 0; i < allReserves.length; i++) {
      AaveV3Avalanche.POOL_CONFIGURATOR.setReserveFreeze(allReserves[i], true);
    }

    AaveV3Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV3AvalancheAssets.USDC_UNDERLYING,
      0,
      86_25,
      10400
    );
  }
}
