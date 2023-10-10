// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthereumUpdate20231009Payload} from './AaveV2Ethereum_20231009.sol';
import {IEngine, EngineFlags} from 'aave-helpers/v2-config-engine/AaveV2PayloadBase.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

contract AaveV2EthereumUpdate_20231009_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18316091);
  }

  function testEthereum20231009UpdatePayload() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preTestEthereumUpdate20231009',
      AaveV2Ethereum.POOL
    );

    GovHelpers.executePayload(
      vm,
      address(new AaveV2EthereumUpdate20231009Payload()),
      AaveGovernanceV2.SHORT_EXECUTOR
    );

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postTestEthereumUpdate20231009',
      AaveV2Ethereum.POOL
    );

    diffReports('preTestEthereumUpdate20231009', 'postTestEthereumUpdate20231009');

    address[] memory assetsChanged = new address[](17);

    assetsChanged[0] = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.BAL_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.BAT_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.CVX_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.DPI_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.ENJ_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.LINK_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.SNX_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.YFI_UNDERLYING;
    assetsChanged[13] = AaveV2EthereumAssets.ZRX_UNDERLYING;
    assetsChanged[14] = AaveV2EthereumAssets.xSUSHI_UNDERLYING;
    assetsChanged[15] = AaveV2EthereumAssets.ENS_UNDERLYING;
    assetsChanged[16] = AaveV2EthereumAssets.UNI_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    {
      ReserveConfig memory ONE_INCH_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ONE_INCH_UNDERLYING
      );
      ONE_INCH_UNDERLYING_CONFIG.ltv = 0;
      ONE_INCH_UNDERLYING_CONFIG.liquidationThreshold = 24_00;
      _validateReserveConfig(ONE_INCH_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory BAL_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.BAL_UNDERLYING
      );
      BAL_UNDERLYING_CONFIG.liquidationThreshold = 25_00;
      _validateReserveConfig(BAL_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory BAT_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.BAT_UNDERLYING
      );
      BAT_UNDERLYING_CONFIG.liquidationThreshold = 1_00;
      _validateReserveConfig(BAT_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory CRV_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.CRV_UNDERLYING
      );
      CRV_UNDERLYING_CONFIG.liquidationThreshold = 42_00;
      _validateReserveConfig(CRV_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory CVX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.CVX_UNDERLYING
      );
      CVX_UNDERLYING_CONFIG.liquidationThreshold = 33_00;
      _validateReserveConfig(CVX_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory DPI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.DPI_UNDERLYING
      );
      DPI_UNDERLYING_CONFIG.liquidationThreshold = 16_00;
      _validateReserveConfig(DPI_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory ENJ_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ENJ_UNDERLYING
      );
      ENJ_UNDERLYING_CONFIG.liquidationThreshold = 50_00;
      _validateReserveConfig(ENJ_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory ENS_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ENS_UNDERLYING
      );
      ENS_UNDERLYING_CONFIG.liquidationThreshold = 50_00;
      ENS_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(ENS_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.LINK_UNDERLYING
      );
      LINK_UNDERLYING_CONFIG.liquidationThreshold = 82_00;
      LINK_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory MANA_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.MANA_UNDERLYING
      );
      MANA_UNDERLYING_CONFIG.liquidationThreshold = 48_00;
      _validateReserveConfig(MANA_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory MKR_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.MKR_UNDERLYING
      );
      MKR_UNDERLYING_CONFIG.liquidationThreshold = 35_00;
      MKR_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(MKR_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory REN_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.REN_UNDERLYING
      );
      REN_UNDERLYING_CONFIG.liquidationThreshold = 27_00;
      _validateReserveConfig(REN_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory SNX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.SNX_UNDERLYING
      );
      SNX_UNDERLYING_CONFIG.liquidationThreshold = 43_00;
      SNX_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(SNX_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory UNI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.UNI_UNDERLYING
      );
      UNI_UNDERLYING_CONFIG.ltv = 0;
      _validateReserveConfig(UNI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory xSUSHI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.xSUSHI_UNDERLYING
      );
      xSUSHI_UNDERLYING_CONFIG.liquidationThreshold = 28_00;
      _validateReserveConfig(xSUSHI_UNDERLYING_CONFIG, allConfigsAfter);
    }

    {
      ReserveConfig memory YFI_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.YFI_UNDERLYING
      );
      YFI_UNDERLYING_CONFIG.liquidationThreshold = 45_00;
      _validateReserveConfig(YFI_UNDERLYING_CONFIG, allConfigsAfter);

      ReserveConfig memory ZRX_UNDERLYING_CONFIG = _findReserveConfig(
        allConfigsBefore,
        AaveV2EthereumAssets.ZRX_UNDERLYING
      );
      ZRX_UNDERLYING_CONFIG.liquidationThreshold = 37_00;
      _validateReserveConfig(ZRX_UNDERLYING_CONFIG, allConfigsAfter);
    }
    e2eTest(AaveV2Ethereum.POOL);
  }
}
