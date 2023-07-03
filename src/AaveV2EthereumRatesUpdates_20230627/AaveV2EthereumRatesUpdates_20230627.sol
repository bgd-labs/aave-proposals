// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @author @yonikesel - Chaos Labs Inc
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5c1fcbd2561751d899feee2fd2dde9e5d6aa61bd1fcd6ee7c410e19595e3c1f7
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-incremental-reserve-factor-updates-aave-v2-ethereum/13766
 */
contract AaveV2EthereumRatesUpdates_20230627 is AaveV2PayloadEthereum {
  function _postExecute() internal override {
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDP_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      15_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      40_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      25_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      20_00
    );
  }
}
