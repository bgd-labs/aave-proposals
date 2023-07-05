// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumRatesUpdates_20230627} from './AaveV2EthereumRatesUpdates_20230627.sol';

contract AaveV2EthereumRatesUpdates_20230627_Test is ProtocolV2TestBase {
  AaveV2EthereumRatesUpdates_20230627 public proposalPayload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17564111);
  }

  function testPayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAaveV2EthereumRatesUpdates_20230627',
      AaveV2Ethereum.POOL
    );

    // 2. create payload
    proposalPayload = new AaveV2EthereumRatesUpdates_20230627();

    // 3. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestAaveV2EthereumRatesUpdates_20230627',
      AaveV2Ethereum.POOL
    );

    diffReports(
      'preTestAaveV2EthereumRatesUpdates_20230627',
      'postTestAaveV2EthereumRatesUpdates_20230627'
    );

    address[] memory assetsChanged = new address[](18);
    assetsChanged[0] = AaveV2EthereumAssets.DAI_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.TUSD_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.USDC_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.USDP_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.USDT_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.ENS_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[13] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[14] = AaveV2EthereumAssets.SNX_UNDERLYING;
    assetsChanged[15] = AaveV2EthereumAssets.UNI_UNDERLYING;
    assetsChanged[16] = AaveV2EthereumAssets.WBTC_UNDERLYING;
    assetsChanged[17] = AaveV2EthereumAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);
  }
}
