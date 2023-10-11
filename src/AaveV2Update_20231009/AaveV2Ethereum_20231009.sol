// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine, EngineFlags} from 'aave-helpers/v2-config-engine/AaveV2PayloadBase.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title v2 Deprecation Plan, 2023.10.03
 * @author Gauntlet, Chaos Labs
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-deprecation-10-03-2023/15040
 */
contract AaveV2EthereumUpdate20231009Payload is AaveV2PayloadEthereum {
  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      0,
      2400,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      0,
      2500,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAT_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      4200,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      0,
      3300,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      0,
      1600,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      0,
      5000,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      8200,
      10700
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      0,
      4800,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      3500,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      0,
      2700,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      0,
      4300,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      0,
      4500,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      3700,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      0,
      2800,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      5000,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      7000,
      10900
    );
  }
}
