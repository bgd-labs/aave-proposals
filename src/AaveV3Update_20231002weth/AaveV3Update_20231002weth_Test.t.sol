
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {
  AaveV3Optimism,
  AaveV3OptimismAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {
  AaveV3Arbitrum,
  AaveV3ArbitrumAssets
} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {
  AaveV3OptimismUpdate20231002wethPayload
} from './AaveV3Optimism_20231002weth.sol';
import {
  AaveV3ArbitrumUpdate20231002wethPayload
} from './AaveV3Arbitrum_20231002weth.sol';

contract AaveV3OptimismUpdate_20231002weth_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 110337425);
  }

  function testOptimism20231002wethUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestOptimismUpdate20231002weth',
      AaveV3Optimism.POOL
    );

    ReserveConfig memory WETH_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WETH_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3OptimismUpdate20231002wethPayload()),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestOptimismUpdate20231002weth',
      AaveV3Optimism.POOL
    );

    diffReports('preTestOptimismUpdate20231002weth', 'postTestOptimismUpdate20231002weth');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3OptimismAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory WETH_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3OptimismAssets.WETH_UNDERLYING
      );
      WETH_UNDERLYINGBefore.interestRateStrategy = WETH_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(WETH_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Optimism.POOL);
  }
}

contract AaveV3ArbitrumUpdate_20231002weth_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 136860213);
  }

  function testArbitrum20231002wethUpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestArbitrumUpdate20231002weth',
      AaveV3Arbitrum.POOL
    );

    ReserveConfig memory WETH_UNDERLYINGBefore = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.WETH_UNDERLYING
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV3ArbitrumUpdate20231002wethPayload()),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestArbitrumUpdate20231002weth',
      AaveV3Arbitrum.POOL
    );

    diffReports('preTestArbitrumUpdate20231002weth', 'postTestArbitrumUpdate20231002weth');

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3ArbitrumAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory WETH_UNDERLYINGAfter = _findReserveConfig(
        allConfigsAfter,
        AaveV3ArbitrumAssets.WETH_UNDERLYING
      );
      WETH_UNDERLYINGBefore.interestRateStrategy = WETH_UNDERLYINGAfter.interestRateStrategy;
      _validateReserveConfig(WETH_UNDERLYINGBefore, allConfigsAfter);
    }
    e2eTest(AaveV3Arbitrum.POOL);
  }
}