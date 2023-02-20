// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolConfigurator, IPoolDataProvider, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This governance payload sets risk parameters for WBTC and SUSD on AAVE V3 Optimism
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xfbd6cbe0ae2fa721302b9288ec46488ec7e28b7e49641f9650535ba3251bb7a6
 * - Dicussion: https://governance.aave.com/t/arc-gauntlet-risk-parameter-updates-for-avax-v3-and-op-v3-2023-02-16/11940
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
