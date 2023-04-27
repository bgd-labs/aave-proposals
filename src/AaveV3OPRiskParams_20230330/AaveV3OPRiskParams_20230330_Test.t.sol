// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3OPRiskParams_20230330} from './AaveV3OPRiskParams_20230330.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3OPRiskParams_20230330_Test is ProtocolV3TestBase, TestWithExecutor {
  uint256 public constant WBTC_UNDERLYING_LIQ_THRESHOLD = 78_00; // 78.0%
  uint256 public constant WBTC_UNDERLYING_LTV = 73_00; // 73.0%
  uint256 public constant WBTC_UNDERLYING_LIQ_BONUS = 10850; // 8.5%

  uint256 public constant DAI_UNDERLYING_LIQ_THRESHOLD = 83_00; // 83.0%
  uint256 public constant DAI_UNDERLYING_LTV = 78_00; // 78.0%

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 84619167);
    _selectPayloadExecutor(AaveGovernanceV2.OPTIMISM_BRIDGE_EXECUTOR);
  }

  function testPayload() public {
    AaveV3OPRiskParams_20230330 proposalPayload = new AaveV3OPRiskParams_20230330();

    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Optimism.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preAaveV3OPRiskParams_20230330Change', AaveV3Optimism.POOL);

    // 2. execute payload
    _executePayload(address(proposalPayload));

    // 3. create snapshot after payload execution
    createConfigurationSnapshot('postAaveV3OPRiskParams_20230330Change', AaveV3Optimism.POOL);

    // 4. Verify payload:
    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV3Optimism.POOL);

    ReserveConfig memory WBTC_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.WBTC_UNDERLYING
    );

    WBTC_UNDERLYING_CONFIG.liquidationThreshold = WBTC_UNDERLYING_LIQ_THRESHOLD;

    WBTC_UNDERLYING_CONFIG.ltv = WBTC_UNDERLYING_LTV;

    WBTC_UNDERLYING_CONFIG.liquidationBonus = WBTC_UNDERLYING_LIQ_BONUS;

    ProtocolV3TestBase._validateReserveConfig(WBTC_UNDERLYING_CONFIG, allConfigsAfter);

    ReserveConfig memory DAI_UNDERLYING_CONFIG = ProtocolV3TestBase._findReserveConfig(
      allConfigsBefore,
      AaveV3OptimismAssets.DAI_UNDERLYING
    );

    DAI_UNDERLYING_CONFIG.liquidationThreshold = DAI_UNDERLYING_LIQ_THRESHOLD;

    DAI_UNDERLYING_CONFIG.ltv = DAI_UNDERLYING_LTV;

    ProtocolV3TestBase._validateReserveConfig(DAI_UNDERLYING_CONFIG, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preAaveV3OPRiskParams_20230330Change', 'postAaveV3OPRiskParams_20230330Change');
  }
}
