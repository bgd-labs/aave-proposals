// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthRiskParams_20230702} from './AaveV2EthRiskParams_20230702.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

contract AaveV2EthRiskParams_20230702_Test is ProtocolV2TestBase {
  uint256 public constant BAL_LTV = 0; // 65 -> 0
  uint256 public constant BAL_LIQUIDATION_THRESHOLD = 55_00; // 70 -> 55
  uint256 public constant BAL_LIQUIDATION_BONUS = 10800; // unchanged
  uint256 public constant BAL_RF = 30_00; // 20 -> 30

  uint256 public constant BAT_LTV = 0; // 65 -> 0
  uint256 public constant BAT_LIQUIDATION_THRESHOLD = 52_00; // 70 -> 52
  uint256 public constant BAT_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant BAT_RF = 30_00; // 20 -> 30

  uint256 public constant CVX_LTV = 0; // 35 -> 0
  uint256 public constant CVX_LIQUIDATION_THRESHOLD = 40_00; // 45 -> 40
  uint256 public constant CVX_LIQUIDATION_BONUS = 10850; // unchanged
  uint256 public constant CVX_RF = 30_00; // 20 -> 30

  uint256 public constant DPI_LTV = 0; // 65 -> 0
  uint256 public constant DPI_LIQUIDATION_THRESHOLD = 42_00; // 70 -> 42
  uint256 public constant DPI_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant DPI_RF = 30_00; // 20 -> 30

  uint256 public constant ENJ_LTV = 0; // 60 -> 0
  uint256 public constant ENJ_LIQUIDATION_THRESHOLD = 60_00; // 67 -> 60
  uint256 public constant ENJ_LIQUIDATION_BONUS = 11000; // 6 -> 10
  uint256 public constant ENJ_RF = 30_00; // 20 -> 30

  uint256 public constant KNC_LTV = 0; // 60 -> 0
  uint256 public constant KNC_LIQUIDATION_THRESHOLD = 1_00; // 70 -> 1
  uint256 public constant KNC_LIQUIDATION_BONUS = 11000; // unchanged
  uint256 public constant KNC_RF = 30_00; // 20 -> 30

  uint256 public constant MANA_LTV = 0; // 61.5 -> 0
  uint256 public constant MANA_LIQUIDATION_THRESHOLD = 62_00; // 75 -> 62
  uint256 public constant MANA_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant MANA_RF = 45_00; // 35 -> 45

  uint256 public constant REN_LTV = 0; // 55 -> 0
  uint256 public constant REN_LIQUIDATION_THRESHOLD = 40_00; // 60 -> 40
  uint256 public constant REN_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant REN_RF = 30_00; // 20 -> 30

  uint256 public constant xSUSHI_LTV = 0; // 50 -> 0
  uint256 public constant xSUSHI_LIQUIDATION_THRESHOLD = 60_00; // 65 -> 60
  uint256 public constant xSUSHI_LIQUIDATION_BONUS = 11000; // 8.5 -> 10
  uint256 public constant xSUSHI_RF = 45_00; // 35 -> 45

  uint256 public constant YFI_LTV = 0; // 50 -> 0
  uint256 public constant YFI_LIQUIDATION_THRESHOLD = 55_00; // 65 -> 55
  uint256 public constant YFI_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant YFI_RF = 30_00; // 20 -> 30

  uint256 public constant ZRX_LTV = 0; // 55 -> 0
  uint256 public constant ZRX_LIQUIDATION_THRESHOLD = 45_00; // 65 -> 45
  uint256 public constant ZRX_LIQUIDATION_BONUS = 11000; // 7.5 -> 10
  uint256 public constant ZRX_RF = 30_00; // 20 -> 30

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17616056);
  }

  function testPayload() public {
    AaveV2EthRiskParams_20230702 proposalPayload = new AaveV2EthRiskParams_20230702();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2EthRiskParams_20230702Change',
      AaveV2Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2EthRiskParams_20230702Change',
      AaveV2Ethereum.POOL
    );

    // 4. Verify payload:

    // BAL
    ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.BAL_UNDERLYING
    );

    BAL_UNDERLYING_CONFIG.liquidationThreshold = BAL_LIQUIDATION_THRESHOLD;
    BAL_UNDERLYING_CONFIG.ltv = BAL_LTV;
    BAL_UNDERLYING_CONFIG.liquidationBonus = BAL_LIQUIDATION_BONUS;
    BAL_UNDERLYING_CONFIG.reserveFactor = BAL_RF;

    _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);

    // BAT
    ReserveConfig memory BAT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.BAT_UNDERLYING
    );

    BAT_UNDERLYING_CONFIG.liquidationThreshold = BAT_LIQUIDATION_THRESHOLD;
    BAT_UNDERLYING_CONFIG.ltv = BAT_LTV;
    BAT_UNDERLYING_CONFIG.liquidationBonus = BAT_LIQUIDATION_BONUS;
    BAT_UNDERLYING_CONFIG.reserveFactor = BAT_RF;

    _validateReserveConfig(BAT_UNDERLYING_CONFIG, allConfigsAfter);

    // CVX
    ReserveConfig memory CVX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CVX_UNDERLYING
    );

    CVX_UNDERLYING_CONFIG.liquidationThreshold = CVX_LIQUIDATION_THRESHOLD;
    CVX_UNDERLYING_CONFIG.ltv = CVX_LTV;
    CVX_UNDERLYING_CONFIG.liquidationBonus = CVX_LIQUIDATION_BONUS;
    CVX_UNDERLYING_CONFIG.reserveFactor = CVX_RF;

    _validateReserveConfig(CVX_UNDERLYING_CONFIG, allConfigsAfter);

    // DPI
    ReserveConfig memory DPI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.DPI_UNDERLYING
    );

    DPI_UNDERLYING_CONFIG.liquidationThreshold = DPI_LIQUIDATION_THRESHOLD;
    DPI_UNDERLYING_CONFIG.ltv = DPI_LTV;
    DPI_UNDERLYING_CONFIG.liquidationBonus = DPI_LIQUIDATION_BONUS;
    DPI_UNDERLYING_CONFIG.reserveFactor = DPI_RF;

    _validateReserveConfig(DPI_UNDERLYING_CONFIG, allConfigsAfter);

    // ENJ
    ReserveConfig memory ENJ_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ENJ_UNDERLYING
    );

    ENJ_UNDERLYING_CONFIG.liquidationThreshold = ENJ_LIQUIDATION_THRESHOLD;
    ENJ_UNDERLYING_CONFIG.ltv = ENJ_LTV;
    ENJ_UNDERLYING_CONFIG.liquidationBonus = ENJ_LIQUIDATION_BONUS;
    ENJ_UNDERLYING_CONFIG.reserveFactor = ENJ_RF;

    _validateReserveConfig(ENJ_UNDERLYING_CONFIG, allConfigsAfter);

    // KNC
    ReserveConfig memory KNC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.KNC_UNDERLYING
    );

    KNC_UNDERLYING_CONFIG.liquidationThreshold = KNC_LIQUIDATION_THRESHOLD;
    KNC_UNDERLYING_CONFIG.ltv = KNC_LTV;
    KNC_UNDERLYING_CONFIG.liquidationBonus = KNC_LIQUIDATION_BONUS;
    KNC_UNDERLYING_CONFIG.reserveFactor = KNC_RF;

    _validateReserveConfig(KNC_UNDERLYING_CONFIG, allConfigsAfter);

    // MANA
    ReserveConfig memory MANA_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.MANA_UNDERLYING
    );

    MANA_UNDERLYING_CONFIG.liquidationThreshold = MANA_LIQUIDATION_THRESHOLD;
    MANA_UNDERLYING_CONFIG.ltv = MANA_LTV;
    MANA_UNDERLYING_CONFIG.liquidationBonus = MANA_LIQUIDATION_BONUS;
    MANA_UNDERLYING_CONFIG.reserveFactor = MANA_RF;

    _validateReserveConfig(MANA_UNDERLYING_CONFIG, allConfigsAfter);

    // REN
    ReserveConfig memory REN_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.REN_UNDERLYING
    );

    REN_UNDERLYING_CONFIG.liquidationThreshold = REN_LIQUIDATION_THRESHOLD;
    REN_UNDERLYING_CONFIG.ltv = REN_LTV;
    REN_UNDERLYING_CONFIG.liquidationBonus = REN_LIQUIDATION_BONUS;
    REN_UNDERLYING_CONFIG.reserveFactor = REN_RF;

    _validateReserveConfig(REN_UNDERLYING_CONFIG, allConfigsAfter);

    // xSUSHI
    ReserveConfig memory xSUSHI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.xSUSHI_UNDERLYING
    );

    xSUSHI_UNDERLYING_CONFIG.liquidationThreshold = xSUSHI_LIQUIDATION_THRESHOLD;
    xSUSHI_UNDERLYING_CONFIG.ltv = xSUSHI_LTV;
    xSUSHI_UNDERLYING_CONFIG.liquidationBonus = xSUSHI_LIQUIDATION_BONUS;
    xSUSHI_UNDERLYING_CONFIG.reserveFactor = xSUSHI_RF;

    _validateReserveConfig(xSUSHI_UNDERLYING_CONFIG, allConfigsAfter);

    // YFI
    ReserveConfig memory YFI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.YFI_UNDERLYING
    );

    YFI_UNDERLYING_CONFIG.liquidationThreshold = YFI_LIQUIDATION_THRESHOLD;
    YFI_UNDERLYING_CONFIG.ltv = YFI_LTV;
    YFI_UNDERLYING_CONFIG.liquidationBonus = YFI_LIQUIDATION_BONUS;
    YFI_UNDERLYING_CONFIG.reserveFactor = YFI_RF;

    _validateReserveConfig(YFI_UNDERLYING_CONFIG, allConfigsAfter);

    // ZRX
    ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ZRX_UNDERLYING
    );

    ZRX_UNDERLYING_CONFIG.liquidationThreshold = ZRX_LIQUIDATION_THRESHOLD;
    ZRX_UNDERLYING_CONFIG.ltv = ZRX_LTV;
    ZRX_UNDERLYING_CONFIG.liquidationBonus = ZRX_LIQUIDATION_BONUS;
    ZRX_UNDERLYING_CONFIG.reserveFactor = ZRX_RF;

    _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);

    address[] memory assetsChanged = new address[](11);
    assetsChanged[0] = AaveV2EthereumAssets.BAL_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.BAT_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.CVX_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.DPI_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.ENJ_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.KNC_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.xSUSHI_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.YFI_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.ZRX_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    // 5. compare snapshots
    diffReports('preAaveV2EthRiskParams_20230702Change', 'postAaveV2EthRiskParams_20230702Change');

    // 6. E2E Test
    e2eTest(AaveV2Ethereum.POOL);
  }
}
