// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthRiskParams_20230529} from './AaveV3EthRiskParams_20230529.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3LegacyTestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3EthRiskParams_20230529_Test is ProtocolV3LegacyTestBase {
  uint256 public constant WETH_UNDERLYING_LIQ_THRESHOLD = 83_00; // 83.0%
  uint256 public constant WETH_UNDERLYING_LTV = 80_50; // 80.5%

  uint256 public constant WBTC_UNDERLYING_LIQ_THRESHOLD = 78_00; // 78.0%
  uint256 public constant WBTC_UNDERLYING_LTV = 73_00; // 73.0%
  uint256 public constant WBTC_UNDERLYING_LIQ_BONUS = 10500; // 5%

  uint256 public constant DAI_UNDERLYING_LIQ_THRESHOLD = 80_00; // 80.0%
  uint256 public constant DAI_UNDERLYING_LTV = 67_00; // 67.0%

  uint256 public constant USDC_UNDERLYING_LIQ_THRESHOLD = 79_00; // 79.0%
  uint256 public constant USDC_UNDERLYING_LTV = 77_00; // 77.0%

  uint256 public constant LINK_UNDERLYING_LIQ_THRESHOLD = 68_00; // 68.0%
  uint256 public constant LINK_UNDERLYING_LTV = 53_00; // 53.0%
  uint256 public constant LINK_UNDERLYING_LIQ_BONUS = 10700; // 7%

  uint256 public constant wstETH_UNDERLYING_LIQ_THRESHOLD = 80_00; // 80.0%
  uint256 public constant wstETH_UNDERLYING_LTV = 69_00; // 69.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17305356);
  }

  function testPayload() public {
    AaveV3EthRiskParams_20230529 proposalPayload = new AaveV3EthRiskParams_20230529();

    // 1. create snapshot before payload execution
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3EthRiskParams_20230529Change',
      AaveV3Ethereum.POOL
    );

    // 2. execute payload
    GovHelpers.executePayload(vm, address(proposalPayload), AaveGovernanceV2.SHORT_EXECUTOR);

    // 3. create snapshot after payload execution
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3EthRiskParams_20230529Change',
      AaveV3Ethereum.POOL
    );

    // 4. Verify payload:
    ReserveConfig memory WETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    WETH_UNDERLYING_CONFIG.liquidationThreshold = WETH_UNDERLYING_LIQ_THRESHOLD;
    WETH_UNDERLYING_CONFIG.ltv = WETH_UNDERLYING_LTV;

    _validateReserveConfig(WETH_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory WBTC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.WBTC_UNDERLYING
    );

    WBTC_UNDERLYING_CONFIG.liquidationThreshold = WBTC_UNDERLYING_LIQ_THRESHOLD;
    WBTC_UNDERLYING_CONFIG.ltv = WBTC_UNDERLYING_LTV;
    WBTC_UNDERLYING_CONFIG.liquidationBonus = WBTC_UNDERLYING_LIQ_BONUS;

    _validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory DAI_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.DAI_UNDERLYING
    );

    DAI_UNDERLYING_CONFIG.liquidationThreshold = DAI_UNDERLYING_LIQ_THRESHOLD;
    DAI_UNDERLYING_CONFIG.ltv = DAI_UNDERLYING_LTV;

    _validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory USDC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDC_UNDERLYING
    );

    USDC_UNDERLYING_CONFIG.liquidationThreshold = USDC_UNDERLYING_LIQ_THRESHOLD;
    USDC_UNDERLYING_CONFIG.ltv = USDC_UNDERLYING_LTV;

    _validateReserveConfig(USDC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory LINK_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.LINK_UNDERLYING
    );

    LINK_UNDERLYING_CONFIG.liquidationThreshold = LINK_UNDERLYING_LIQ_THRESHOLD;
    LINK_UNDERLYING_CONFIG.ltv = LINK_UNDERLYING_LTV;
    LINK_UNDERLYING_CONFIG.liquidationBonus = LINK_UNDERLYING_LIQ_BONUS;

    _validateReserveConfig(LINK_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory wstETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.wstETH_UNDERLYING
    );

    wstETH_UNDERLYING_CONFIG.liquidationThreshold = wstETH_UNDERLYING_LIQ_THRESHOLD;
    wstETH_UNDERLYING_CONFIG.ltv = wstETH_UNDERLYING_LTV;

    _validateReserveConfig(wstETH_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3EthRiskParams_20230529Change', 'postAaveV3EthRiskParams_20230529Change');
  }
}
