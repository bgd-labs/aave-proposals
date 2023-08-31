// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831} from './AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831.sol';

/**
 * @dev Test for AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831
 * command: make test-contract filter=AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831
 */
contract AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831_Test is ProtocolV2TestBase {
  AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18033340);
    proposal = new AaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831();
  }

  function testProposalExecutionPartOne() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831',
      AaveV2Ethereum.POOL
    );

    validateAssetBatchOne(allConfigsBefore, allConfigsAfter);
    validateAssetBatchTwo(allConfigsBefore, allConfigsAfter);
    validateAssetBatchThree(allConfigsBefore, allConfigsAfter);

    diffReports(
      'preAaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831',
      'postAaveV2_Ethereum_ChaosLabsRiskParameterUpdates_20230831'
    );

    e2eTest(AaveV2Ethereum.POOL);
  }

  function validateAssetBatchOne(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter
  ) public pure {
    // BAL
    ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.BAL_UNDERLYING
    );

    BAL_UNDERLYING_CONFIG.liquidationThreshold = 35_00;
    BAL_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);

    // BAT
    ReserveConfig memory BAT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.BAT_UNDERLYING
    );

    BAT_UNDERLYING_CONFIG.liquidationThreshold = 40_00;
    BAT_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(BAT_UNDERLYING_CONFIG, allConfigsAfter);

    // CVX
    ReserveConfig memory CVX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CVX_UNDERLYING
    );

    CVX_UNDERLYING_CONFIG.liquidationThreshold = 35_00;
    CVX_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(CVX_UNDERLYING_CONFIG, allConfigsAfter);

    // DPI
    ReserveConfig memory DPI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.DPI_UNDERLYING
    );

    DPI_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(DPI_UNDERLYING_CONFIG, allConfigsAfter);

    // ENJ
    ReserveConfig memory ENJ_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ENJ_UNDERLYING
    );

    ENJ_UNDERLYING_CONFIG.liquidationThreshold = 52_00;
    ENJ_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(ENJ_UNDERLYING_CONFIG, allConfigsAfter);

    // MANA
    ReserveConfig memory MANA_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.MANA_UNDERLYING
    );

    MANA_UNDERLYING_CONFIG.liquidationThreshold = 54_00;
    MANA_UNDERLYING_CONFIG.reserveFactor = 50_00;

    _validateReserveConfig(MANA_UNDERLYING_CONFIG, allConfigsAfter);

    // REN
    ReserveConfig memory REN_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.REN_UNDERLYING
    );

    REN_UNDERLYING_CONFIG.liquidationThreshold = 32_00;
    REN_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(REN_UNDERLYING_CONFIG, allConfigsAfter);

    // xSUSHI
    ReserveConfig memory xSUSHI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.xSUSHI_UNDERLYING
    );

    xSUSHI_UNDERLYING_CONFIG.liquidationThreshold = 57_00;
    xSUSHI_UNDERLYING_CONFIG.reserveFactor = 50_00;

    _validateReserveConfig(xSUSHI_UNDERLYING_CONFIG, allConfigsAfter);

    // YFI
    ReserveConfig memory YFI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.YFI_UNDERLYING
    );

    YFI_UNDERLYING_CONFIG.liquidationThreshold = 50_00;
    YFI_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(YFI_UNDERLYING_CONFIG, allConfigsAfter);

    // ZRX
    ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ZRX_UNDERLYING
    );

    ZRX_UNDERLYING_CONFIG.liquidationThreshold = 42_00;
    ZRX_UNDERLYING_CONFIG.reserveFactor = 35_00;

    _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);

    // LINK
    ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.LINK_UNDERLYING
    );

    LINK_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);

    // 1INCH
    ReserveConfig memory ONE_INCH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING
    );

    ONE_INCH_UNDERLYING_CONFIG.liquidationThreshold = 40_00;
    ONE_INCH_UNDERLYING_CONFIG.ltv = 30_00;
    ONE_INCH_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(ONE_INCH_UNDERLYING_CONFIG, allConfigsAfter);

    // UNI
    ReserveConfig memory UNI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.UNI_UNDERLYING
    );

    UNI_UNDERLYING_CONFIG.liquidationThreshold = 70_00;
    UNI_UNDERLYING_CONFIG.ltv = 58_00;
    UNI_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(UNI_UNDERLYING_CONFIG, allConfigsAfter);
  }

  function validateAssetBatchTwo(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter
  ) public pure {
    // SNX
    ReserveConfig memory SNX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.SNX_UNDERLYING
    );

    SNX_UNDERLYING_CONFIG.liquidationThreshold = 49_00;
    SNX_UNDERLYING_CONFIG.ltv = 36_00;
    SNX_UNDERLYING_CONFIG.reserveFactor = 45_00;

    _validateReserveConfig(SNX_UNDERLYING_CONFIG, allConfigsAfter);

    // MKR
    ReserveConfig memory MKR_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.MKR_UNDERLYING
    );

    MKR_UNDERLYING_CONFIG.liquidationThreshold = 50_00;
    MKR_UNDERLYING_CONFIG.ltv = 45_00;
    MKR_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(MKR_UNDERLYING_CONFIG, allConfigsAfter);

    // ENS
    ReserveConfig memory ENS_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.ENS_UNDERLYING
    );

    ENS_UNDERLYING_CONFIG.liquidationThreshold = 52_00;
    ENS_UNDERLYING_CONFIG.ltv = 42_00;
    ENS_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(ENS_UNDERLYING_CONFIG, allConfigsAfter);

    // FRAX
    ReserveConfig memory FRAX_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.FRAX_UNDERLYING
    );

    FRAX_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(FRAX_UNDERLYING_CONFIG, allConfigsAfter);

    // GUSD
    ReserveConfig memory GUSD_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.GUSD_UNDERLYING
    );

    GUSD_UNDERLYING_CONFIG.reserveFactor = 20_00;

    _validateReserveConfig(GUSD_UNDERLYING_CONFIG, allConfigsAfter);

    // LUSD
    ReserveConfig memory LUSD_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.LUSD_UNDERLYING
    );

    LUSD_UNDERLYING_CONFIG.reserveFactor = 20_00;

    _validateReserveConfig(LUSD_UNDERLYING_CONFIG, allConfigsAfter);

    // sUSD
    ReserveConfig memory sUSD_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.sUSD_UNDERLYING
    );

    sUSD_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(sUSD_UNDERLYING_CONFIG, allConfigsAfter);

    // USDC
    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.USDC_UNDERLYING
    );

    USDC_UNDERLYING_CONFIG.reserveFactor = 20_00;

    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

    // USDP
    ReserveConfig memory USDP_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.USDP_UNDERLYING
    );

    USDP_UNDERLYING_CONFIG.reserveFactor = 20_00;

    _validateReserveConfig(USDP_UNDERLYING_CONFIG, allConfigsAfter);

    // USDT
    ReserveConfig memory USDT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.USDT_UNDERLYING
    );

    USDT_UNDERLYING_CONFIG.reserveFactor = 20_00;

    _validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

    // CRV
    ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.CRV_UNDERLYING
    );

    CRV_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);
  }

  function validateAssetBatchThree(
    ReserveConfig[] memory allConfigsBefore,
    ReserveConfig[] memory allConfigsAfter
  ) public pure {
    // WBTC
    ReserveConfig memory WBTC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.WBTC_UNDERLYING
    );

    WBTC_UNDERLYING_CONFIG.reserveFactor = 30_00;

    _validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    // WETH
    ReserveConfig memory WETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV2EthereumAssets.WETH_UNDERLYING
    );

    WETH_UNDERLYING_CONFIG.reserveFactor = 25_00;

    _validateReserveConfig(WETH_UNDERLYING_CONFIG, allConfigsAfter);
  }
}
