// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3ArbMAICapsUpdates_20230724} from './AaveV3ArbMAICapsUpdates_20230724.sol';
import {AaveV3OptMAICapsUpdates_20230724} from './AaveV3OptMAICapsUpdates_20230724.sol';
import {AaveV3PolMAICapsUpdates_20230724} from './AaveV3PolMAICapsUpdates_20230724.sol';
import {AaveV3AvaxMAICapsUpdates_20230724} from './AaveV3AvaxMAICapsUpdates_20230724.sol';

contract AaveV3ArbMAICapsUpdates_20230724_Test is ProtocolV3TestBase {
  uint256 public constant ARB_NEW_SUPPLY_CAP_MAI = 325_000;
  uint256 public constant ARB_NEW_BORROW_CAP_MAI = 250_000;
  uint256 public constant ARB_NEW_DEBT_CEILING_MAI = 100_000_00;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 113932316);
  }

  function testPayload() public {
    AaveV3ArbMAICapsUpdates_20230724 arbitrumPayload = new AaveV3ArbMAICapsUpdates_20230724();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3ArbMAICapsUpdates_20230724Change',
      AaveV3Arbitrum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(arbitrumPayload),
      AaveGovernanceV2.ARBITRUM_BRIDGE_EXECUTOR
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3ArbMAICapsUpdates_20230724Change',
      AaveV3Arbitrum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory MAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3ArbitrumAssets.MAI_UNDERLYING
    );

    MAI_UNDERLYING_CONFIG.supplyCap = ARB_NEW_SUPPLY_CAP_MAI;
    MAI_UNDERLYING_CONFIG.borrowCap = ARB_NEW_BORROW_CAP_MAI;
    MAI_UNDERLYING_CONFIG.debtCeiling = ARB_NEW_DEBT_CEILING_MAI;

    _validateReserveConfig(MAI_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3ArbMAICapsUpdates_20230724Change',
      'postAaveV3ArbMAICapsUpdates_20230724Change'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3ArbitrumAssets.MAI_UNDERLYING
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Arbitrum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3ArbitrumAssets.MAI_UNDERLYING)
    );
  }
}

contract AaveV3PolMAICapsUpdates_20230724_Test is ProtocolV3TestBase {
  uint256 public constant POL_NEW_SUPPLY_CAP_MAI = 900_000;
  uint256 public constant POL_NEW_BORROW_CAP_MAI = 700_000;
  uint256 public constant POL_NEW_DEBT_CEILING_MAI = 180_000_00;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 45505017);
  }

  function testPayload() public {
    AaveV3PolMAICapsUpdates_20230724 polygonPayload = new AaveV3PolMAICapsUpdates_20230724();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3PolMAICapsUpdates_20230724Change',
      AaveV3Polygon.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(polygonPayload),
      AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3PolMAICapsUpdates_20230724Change',
      AaveV3Polygon.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory MAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3PolygonAssets.miMATIC_UNDERLYING
    );

    MAI_UNDERLYING_CONFIG.supplyCap = POL_NEW_SUPPLY_CAP_MAI;
    MAI_UNDERLYING_CONFIG.borrowCap = POL_NEW_BORROW_CAP_MAI;
    MAI_UNDERLYING_CONFIG.debtCeiling = POL_NEW_DEBT_CEILING_MAI;

    _validateReserveConfig(MAI_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3PolMAICapsUpdates_20230724Change',
      'postAaveV3PolMAICapsUpdates_20230724Change'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3PolygonAssets.miMATIC_UNDERLYING
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Polygon.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3PolygonAssets.miMATIC_UNDERLYING)
    );
  }
}

contract AaveV3OptMAICapsUpdates_20230724_Test is ProtocolV3TestBase {
  uint256 public constant OP_NEW_SUPPLY_CAP_MAI = 650_000;
  uint256 public constant OP_NEW_BORROW_CAP_MAI = 525_000;
  uint256 public constant OP_NEW_DEBT_CEILING_MAI = 130_000_00;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 107291747);
  }

  function testPayload() public {
    AaveV3OptMAICapsUpdates_20230724 optimismPayload = new AaveV3OptMAICapsUpdates_20230724();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3OptMAICapsUpdates_20230724Change',
      AaveV3Optimism.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(optimismPayload),
      AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3OptMAICapsUpdates_20230724Change',
      AaveV3Optimism.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory MAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.MAI_UNDERLYING
    );

    MAI_UNDERLYING_CONFIG.supplyCap = OP_NEW_SUPPLY_CAP_MAI;
    MAI_UNDERLYING_CONFIG.borrowCap = OP_NEW_BORROW_CAP_MAI;
    MAI_UNDERLYING_CONFIG.debtCeiling = OP_NEW_DEBT_CEILING_MAI;

    _validateReserveConfig(MAI_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3OptMAICapsUpdates_20230724Change',
      'postAaveV3OptMAICapsUpdates_20230724Change'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3OptimismAssets.MAI_UNDERLYING
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Optimism.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.DAI_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3OptimismAssets.MAI_UNDERLYING)
    );
  }
}

contract AaveV3AvaxMAICapsUpdates_20230724_Test is ProtocolV3TestBase {
  uint256 public constant AVAX_NEW_SUPPLY_CAP_MAI = 20_000;
  uint256 public constant AVAX_NEW_BORROW_CAP_MAI = 10_000;
  uint256 public constant AVAX_NEW_DEBT_CEILING_MAI = 10_000_00;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 33064566);
  }

  function testPayload() public {
    AaveV3AvaxMAICapsUpdates_20230724 avalanchePayload = new AaveV3AvaxMAICapsUpdates_20230724();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3AvaxMAICapsUpdates_20230724Change',
      AaveV3Avalanche.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(
      vm,
      address(avalanchePayload),
      0xa35b76E4935449E33C56aB24b23fcd3246f13470 // avalanche guardian
    );

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3AvaxMAICapsUpdates_20230724Change',
      AaveV3Avalanche.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory MAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3AvalancheAssets.MAI_UNDERLYING
    );

    MAI_UNDERLYING_CONFIG.supplyCap = AVAX_NEW_SUPPLY_CAP_MAI;
    MAI_UNDERLYING_CONFIG.borrowCap = AVAX_NEW_BORROW_CAP_MAI;
    MAI_UNDERLYING_CONFIG.debtCeiling = AVAX_NEW_DEBT_CEILING_MAI;

    _validateReserveConfig(MAI_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports(
      'preAaveV3AvaxMAICapsUpdates_20230724Change',
      'postAaveV3AvaxMAICapsUpdates_20230724Change'
    );

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      AaveV3AvalancheAssets.MAI_UNDERLYING
    );

    // 6. e2e
    e2eTestAsset(
      AaveV3Avalanche.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3AvalancheAssets.DAIe_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3AvalancheAssets.MAI_UNDERLYING)
    );
  }
}
