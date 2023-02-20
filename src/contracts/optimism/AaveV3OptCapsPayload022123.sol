// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, IPoolDataProvider, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This governance payload sets risk parameters for WBTC and SUSD on AAVE V3 Optimism
 * - Snapshot: TBD
 * - Dicussion: TBD
 */
contract AaveV3OptCapsPayload is IProposalGenericExecutor {
  address public constant WBTC = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;
  address public constant SUSD = 0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Optimism.POOL_CONFIGURATOR;

    configurator.configureReserveAsCollateral({
      asset: WBTC,
      ltv: 7000,
      liquidationThreshold: 7500,
      // previous value: 11000
      liquidationBonus: 10940
    });

    configurator.configureReserveAsCollateral({
      asset: SUSD,
      ltv: 6000,
      liquidationThreshold: 7500,
      // previous value: 10500
      liquidationBonus: 10540
    });
  }
}
