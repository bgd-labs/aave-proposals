// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Eth_AaveV3USDTRiskParams_20231107} from './AaveV3_Eth_AaveV3USDTRiskParams_20231107.sol';

/**
 * @dev Test for AaveV3_Eth_AaveV3USDTRiskParams_20231107
 * command: make test-contract filter=AaveV3_Eth_AaveV3USDTRiskParams_20231107
 */
contract AaveV3_Eth_AaveV3USDTRiskParams_20231107_Test is ProtocolV3TestBase {
  uint256 public constant USDT_UNDERLYING_LTV = 74_00; // 74.0%
  uint256 public constant USDT_UNDERLYING_LIQ_THRESHOLD = 76_00; // 76.0%
  uint256 public constant USDT_UNDERLYING_LIQ_BONUS = 10450; // 4.5%
  uint256 public constant USDT_LIQUIDATION_PROTOCOL_FEE = 10_00; // 10.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17669523);
  }

  function testProposalExecution() public {
    AaveV3_Eth_AaveV3USDTRiskParams_20231107 proposal = new AaveV3_Eth_AaveV3USDTRiskParams_20231107();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Eth_AaveV3USDTRiskParams_20231107',
      AaveV3Ethereum.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Eth_AaveV3USDTRiskParams_20231107',
      AaveV3Ethereum.POOL
    );

    ReserveConfig memory USDT_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3EthereumAssets.USDT_UNDERLYING
    );

    USDT_UNDERLYING_CONFIG.liquidationThreshold = USDT_UNDERLYING_LIQ_THRESHOLD;

    USDT_UNDERLYING_CONFIG.ltv = USDT_UNDERLYING_LTV;

    USDT_UNDERLYING_CONFIG.liquidationBonus = USDT_UNDERLYING_LIQ_BONUS;

    USDT_UNDERLYING_CONFIG.liquidationProtocolFee = USDT_LIQUIDATION_PROTOCOL_FEE;

    USDT_UNDERLYING_CONFIG.usageAsCollateralEnabled = true;

    _validateReserveConfig(USDT_UNDERLYING_CONFIG, allConfigsAfter);

    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDT_UNDERLYING)
    );
    e2eTestAsset(
      AaveV3Ethereum.POOL,
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDT_UNDERLYING),
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.USDC_UNDERLYING)
    );

    diffReports(
      'preAaveV3_Eth_AaveV3USDTRiskParams_20231107',
      'postAaveV3_Eth_AaveV3USDTRiskParams_20231107'
    );
  }
}
