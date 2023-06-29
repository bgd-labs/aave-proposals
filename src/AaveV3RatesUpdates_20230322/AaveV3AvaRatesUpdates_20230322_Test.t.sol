// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3AvaRatesUpdates_20230322} from './AaveV3AvaRatesUpdates_20230322.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3AvaRatesUpdates_20230322_Test is ProtocolV3LegacyTestBase {
  address internal constant AVAX_GUARDIAN = 0xa35b76E4935449E33C56aB24b23fcd3246f13470;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 27701185);
  }

  function testExecuteValidation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-AaveV3Avalanche-interestRateUpdate-wAVAX',
      AaveV3Avalanche.POOL
    );

    ReserveConfig memory wavaxBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.WAVAX_UNDERLYING
    );

    GovHelpers.executePayload(vm, address(new AaveV3AvaRatesUpdates_20230322()), AVAX_GUARDIAN);

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-AaveV3Avalanche-interestRateUpdate-wAVAX',
      AaveV3Avalanche.POOL
    );

    ReserveConfig memory wavaxAfter = _findReserveConfig(
      allConfigs,
      AaveV3AvalancheAssets.WAVAX_UNDERLYING
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3AvalancheAssets.WAVAX_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigs, assetsChanged);

    wavaxBefore.interestRateStrategy = wavaxAfter.interestRateStrategy;
    _validateReserveConfig(wavaxBefore, allConfigs);

    diffReports(
      'pre-AaveV3Avalanche-interestRateUpdate-wAVAX',
      'post-AaveV3Avalanche-interestRateUpdate-wAVAX'
    );
  }
}
