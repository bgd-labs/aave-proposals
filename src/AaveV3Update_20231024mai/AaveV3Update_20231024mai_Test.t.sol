// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {AaveV3ArbitrumUpdate20231024maiPayload} from './AaveV3Arbitrum_20231024mai.sol';
import {AaveV3OptimismUpdate20231024maiPayload} from './AaveV3Optimism_20231024mai.sol';
import {AaveV3PolygonUpdate20231024maiPayload} from './AaveV3Polygon_20231024mai.sol';
import {AaveV3AvalancheUpdate20231024maiPayload} from './AaveV3Avalanche_20231024mai.sol';

contract AaveV3ArbitrumUpdate_20231024mai_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 144607981);
  }

  function testArbitrum20231024maiUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbitrumUpdate20231024mai',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory MAI_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.MAI_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3ArbitrumUpdate20231024maiPayload()),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestArbitrumUpdate20231024mai',
      AaveV3Arbitrum.POOL
    );

    diffReports('preTestArbitrumUpdate20231024mai', 'postTestArbitrumUpdate20231024mai');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3ArbitrumAssets.MAI_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory MAI_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3ArbitrumAssets.MAI_UNDERLYING
      );
      MAI_UNDERLYINGBefore.liquidationThreshold = 0;
      MAI_UNDERLYINGBefore.reserveFactor = 9500;
      MAI_UNDERLYINGBefore.interestRateStrategy = MAI_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(MAI_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Arbitrum.POOL);
  }
}

contract AaveV3OptimismUpdate_20231024mai_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 111419500);
  }

  function testOptimism20231024maiUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestOptimismUpdate20231024mai',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory MAI_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.MAI_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3OptimismUpdate20231024maiPayload()),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestOptimismUpdate20231024mai',
      AaveV3Optimism.POOL
    );

    diffReports('preTestOptimismUpdate20231024mai', 'postTestOptimismUpdate20231024mai');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3OptimismAssets.MAI_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory MAI_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3OptimismAssets.MAI_UNDERLYING
      );
      MAI_UNDERLYINGBefore.liquidationThreshold = 6500;
      MAI_UNDERLYINGBefore.reserveFactor = 9500;
      MAI_UNDERLYINGBefore.interestRateStrategy = MAI_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(MAI_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Optimism.POOL);
  }
}

contract AaveV3PolygonUpdate_20231024mai_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49227175);
  }

  function testPolygon20231024maiUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestPolygonUpdate20231024mai',
      AaveV3Polygon.POOL
    );

    ReserveConfig memory miMATIC_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.miMATIC_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3PolygonUpdate20231024maiPayload()),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestPolygonUpdate20231024mai',
      AaveV3Polygon.POOL
    );

    diffReports('preTestPolygonUpdate20231024mai', 'postTestPolygonUpdate20231024mai');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3PolygonAssets.miMATIC_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory miMATIC_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3PolygonAssets.miMATIC_UNDERLYING
      );
      miMATIC_UNDERLYINGBefore.liquidationThreshold = 0;
      miMATIC_UNDERLYINGBefore.reserveFactor = 9500;
      miMATIC_UNDERLYINGBefore.interestRateStrategy = miMATIC_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(miMATIC_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Polygon.POOL);
  }
}

contract AaveV3AvalancheUpdate_20231024mai_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37000776);
  }

  function testAvalanche20231024maiUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestAvalancheUpdate20231024mai',
      AaveV3Avalanche.POOL
    );

    ReserveConfig memory MAI_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.MAI_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3AvalancheUpdate20231024maiPayload()),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestAvalancheUpdate20231024mai',
      AaveV3Avalanche.POOL
    );

    diffReports('preTestAvalancheUpdate20231024mai', 'postTestAvalancheUpdate20231024mai');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3AvalancheAssets.MAI_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory MAI_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3AvalancheAssets.MAI_UNDERLYING
      );
      MAI_UNDERLYINGBefore.liquidationThreshold = 0;
      MAI_UNDERLYINGBefore.reserveFactor = 9500;
      MAI_UNDERLYINGBefore.interestRateStrategy = MAI_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(MAI_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Avalanche.POOL);
  }
}
