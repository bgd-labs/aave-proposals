// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Opt_RiskParamsUpdate_20232408} from './AaveV3_Opt_RiskParamsUpdate_20232408.sol';

/**
 * @dev Test for AaveV3_Opt_RiskParamsUpdate_20232408
 * command: make test-contract filter=AaveV3_Opt_RiskParamsUpdate_20232408
 */
contract AaveV3_Opt_RiskParamsUpdate_20232408_Test is ProtocolV3TestBase {
  uint256 public constant WBTC_UNDERLYING_LIQ_BONUS = 10_750; // 7.5%

  uint256 public constant wstETH_UNDERLYING_LIQ_THRESHOLD = 80_00; // 80.0%
  uint256 public constant wstETH_UNDERLYING_LTV = 71_00; // 71.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 108641143);
  }

  function testProposalExecution() public {
    AaveV3_Opt_RiskParamsUpdate_20232408 proposal = new AaveV3_Opt_RiskParamsUpdate_20232408();

    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3_Opt_RiskParamsUpdate_20232408',
      AaveV3Optimism.POOL
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3_Opt_RiskParamsUpdate_20232408',
      AaveV3Optimism.POOL
    );

    diffReports(
      'preAaveV3_Opt_RiskParamsUpdate_20232408',
      'postAaveV3_Opt_RiskParamsUpdate_20232408'
    );

    // WBTC
    ReserveConfig memory WBTC_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WBTC_UNDERLYING
    );
    WBTC_UNDERLYING_CONFIG.liquidationBonus = WBTC_UNDERLYING_LIQ_BONUS;
    _validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    // wstETH
    ReserveConfig memory wstETH_UNDERLYING_CONFIG = _findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.wstETH_UNDERLYING
    );
    wstETH_UNDERLYING_CONFIG.ltv = wstETH_UNDERLYING_LTV;
    wstETH_UNDERLYING_CONFIG.liquidationThreshold = wstETH_UNDERLYING_LIQ_THRESHOLD;
    _validateReserveConfig(wstETH_UNDERLYING_CONFIG, allConfigsAfter);
    
    e2eTest(AaveV3Optimism.POOL);
  }
}
