// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import 'forge-std/Test.sol';

import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3AvaRatesUpdatesSteward_20230331} from './AaveV3AvaxRatesUpdatesSteward_20230331.sol';

contract AaveV3AvaCapsByGuardian is ProtocolV3LegacyTestBase {
  using stdStorage for StdStorage;

  address public constant GUARDIAN_AVALANCHE = 0xa35b76E4935449E33C56aB24b23fcd3246f13470;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 28120569);
  }

  function testUpdatesRatesAndReserveFactors() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAvaRatesUpdateMar31',
      AaveV3Avalanche.POOL
    );

    ReserveConfig memory usdtBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.USDt_UNDERLYING
    );

    ReserveConfig memory maiBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.MAI_UNDERLYING
    );

    ReserveConfig memory wethBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.WETHe_UNDERLYING
    );

    ReserveConfig memory fraxBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.FRAX_UNDERLYING
    );

    AaveV3AvaRatesUpdatesSteward_20230331 rateSteward = new AaveV3AvaRatesUpdatesSteward_20230331();
    GovHelpers.executePayload(vm, address(rateSteward), GUARDIAN_AVALANCHE);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestAvaRatesUpdateMar31',
      AaveV3Avalanche.POOL
    );

    diffReports('preTestAvaRatesUpdateMar31', 'postTestAvaRatesUpdateMar31');

    address[] memory assetsChanged = new address[](4);
    assetsChanged[0] = AaveV3AvalancheAssets.USDt_UNDERLYING;
    assetsChanged[1] = AaveV3AvalancheAssets.MAI_UNDERLYING;
    assetsChanged[2] = AaveV3AvalancheAssets.WETHe_UNDERLYING;
    assetsChanged[3] = AaveV3AvalancheAssets.FRAX_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory usdtAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3AvalancheAssets.USDt_UNDERLYING
      );
      usdtBefore.interestRateStrategy = usdtAfter.interestRateStrategy;
      _validateReserveConfig(usdtBefore, allConfigsAfter);
    }

    {
      ReserveConfig memory maiAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3AvalancheAssets.MAI_UNDERLYING
      );
      maiBefore.interestRateStrategy = maiAfter.interestRateStrategy;
      maiBefore.reserveFactor = 20_00;
      _validateReserveConfig(maiBefore, allConfigsAfter);
    }

    {
      ReserveConfig memory fraxAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3AvalancheAssets.FRAX_UNDERLYING
      );
      fraxBefore.interestRateStrategy = fraxAfter.interestRateStrategy;
      _validateReserveConfig(fraxBefore, allConfigsAfter);
    }

    {
      ReserveConfig memory wethAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3AvalancheAssets.WETHe_UNDERLYING
      );
      wethBefore.interestRateStrategy = wethAfter.interestRateStrategy;
      wethBefore.reserveFactor = 15_00;
      _validateReserveConfig(wethBefore, allConfigsAfter);
    }
  }
}
