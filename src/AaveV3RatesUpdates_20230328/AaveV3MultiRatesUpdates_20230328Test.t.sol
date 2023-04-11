// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.17;

import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PolRatesUpdates_20230328} from './AaveV3PolRatesUpdates_20230328.sol';
import {AaveV3EthRatesUpdates_20230328} from './AaveV3EthRatesUpdates_20230328.sol';
import {ProtocolV3_0_1TestBase, ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3PolRatesUpdates_20230328Test is ProtocolV3TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 41383971);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testExecuteValidation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-AaveV3Polygon-interestRateUpdate-20230328',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory balBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.BAL_UNDERLYING
    );

    _executePayload(address(new AaveV3PolRatesUpdates_20230328()));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-AaveV3Polygon-interestRateUpdate-20230328',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory balAfter = _findReserveConfig(
      allConfigs,
      AaveV3PolygonAssets.BAL_UNDERLYING
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.BAL_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigs, assetsChanged);

    balBefore.interestRateStrategy = balAfter.interestRateStrategy;
    _validateReserveConfig(balBefore, allConfigs);

    diffReports(
      'pre-AaveV3Polygon-interestRateUpdate-20230328',
      'post-AaveV3Polygon-interestRateUpdate-20230328'
    );
  }
}

contract AaveV3EthRatesUpdates_20230328Test is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17020741);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testExecuteValidation() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-AaveV3Ethereum-interestRateUpdate-20230328',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory balBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.BAL_UNDERLYING
    );

    _executePayload(address(new AaveV3EthRatesUpdates_20230328()));

    ReserveConfig[] memory allConfigs = createConfigurationSnapshot(
      'post-AaveV3Ethereum-interestRateUpdate-20230328',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory balAfter = _findReserveConfig(
      allConfigs,
      AaveV2EthereumAssets.BAL_UNDERLYING
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigs, assetsChanged);

    balBefore.interestRateStrategy = balAfter.interestRateStrategy;
    _validateReserveConfig(balBefore, allConfigs);

    diffReports(
      'pre-AaveV3Ethereum-interestRateUpdate-20230328',
      'post-AaveV3Ethereum-interestRateUpdate-20230328'
    );
  }
}
